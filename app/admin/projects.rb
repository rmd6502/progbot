ActiveAdmin.register Project do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

  permit_params :name, :status, :description, :website,
                :slack_channel, :mission_aligned, skill_ids: [], volunteer_ids: [], lead_ids: []

  index do
    selectable_column
    column :name
    column :status
    column :description do |project|
      span project.description.try(:truncate, 30), :title => project.description
    end
    column :lead do |project|
      project.leads.map(&:name).to_sentence
    end
    column :website do |project|
      project.website.try(:truncate, 20)
    end
    column :slack_channel
    column :stacks do |project|
      span project.stacks.map(&:name).to_sentence
    end
    column :volunteers do |project|
      c = project.volunteers.count
      span "#{c} volunteer#{c == 1 ? '' : 's'}"
    end
    actions
  end

  show do
    attributes_table do
      row :name
      row :status do
        span project.status.join(', ')
      end
      row :mission_aligned
      row :description
      row :website
      row :slack_channel
      row :leads do
        span project.leads.map(&:slack_username).to_sentence
      end
      row "Skills" do
        span project.stacks.map(&:name).to_sentence
      end
      row :volunteers do
        span project.volunteers.map(&:name).to_sentence
      end
    end
  end

  controller do 

    def update
      resource.assign_attributes(permitted_params['project'])
      if resource.mission_aligned_changed?
        mission_aligned_changed = true
        mission_aligned_was = resource.mission_aligned_status(resource.mission_aligned_was)
      else
        mission_aligned_changed = false
      end

      if resource.save
        if mission_aligned_changed == true && resource.leads.any?
          resource.send_mission_aligned_changed_notification_email(mission_aligned_was)
          resource.send_mission_aligned_changed_slack_notifications(mission_aligned_was)
        end
        redirect_to admin_project_path(resource)
      else
        render :edit
      end
    end

  end

  form do |f|
    f.inputs "Basic Info" do
      f.input :name
      f.input :status
      f.input :description
      f.input :website
      f.input :slack_channel
      f.input :mission_aligned
    end

    f.inputs "Selections" do

      f.input :lead_ids, :label => "Project Leads", :as => :select, :collection => options_from_collection_for_select(User.all.pluck(:slack_username, :id), :second, :first, User.where(id: project.lead_ids).pluck(:id)), :input_html => { multiple: true, size: 60, class: 'select2' }

      f.input :stacks, :input_html => { multiple: true, size: 60, class: 'select2' }

      f.input :volunteers, collection: User.all.map(&:slack_username), :selected => project.volunteers.map(&:slack_username), :input_html => { multiple: true, size: 60, class: 'select2' }
    end
    f.actions
  end
end
