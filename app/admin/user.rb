ActiveAdmin.register User do

  index do
    selectable_column
    id_column
    column :name
    column :email
    column 'Role' do |user|
      user.roles.present? ? (user.roles.first.name) : "guest"
    end
    actions defaults: true do |user|
      link_to 'Change Role', change_role_new_admin_user_path(user)
    end
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs "User Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  member_action :change_role_new, :method => :get do
  end

  member_action :create_role, :method => :get do
    user = User.find(params[:id])
    user.add_role(params[:role]) if params[:role].present?
    redirect_to admin_users_path, notice: "Role created successfully."
  end

end
