class UserMailer < Devise::Mailer

private

 def headers_for(action, opts)
  if action == :confirmation_instructions
    opts[:subject] = "Confirm your #{t(:site_name)} account"
  elsif action == :reset_password_instructions
    opts[:subject] = "Reset your #{t(:site_name)} password"
  else
    opts[:subject] = "Unlock your #{t(:site_name)} account"
  end
  super(action, opts)
 end
end