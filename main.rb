# frozen_string_literal: true

require 'English'
require 'pathname'
require 'fileutils'

def get_env_variable(key)
  ENV[key].nil? || ENV[key] == '' ? nil : ENV[key]
end

def run_command(cmd)
  puts "@@[command] #{cmd}"
  output = `#{cmd}`
  puts output
  $CHILD_STATUS.success?
end

ac_repo_path = get_env_variable('AC_REPOSITORY_DIR') || abort('Missing repo path.')
ac_project_path = get_env_variable('AC_PROJECT_PATH') || '.'

task = get_env_variable('AC_DETEKT_TASK') || abort('Missing gradle task.')
extra = get_env_variable('AC_DETEKT_EXTRA_PARAMETERS')
save_report = get_env_variable('AC_DETEKT_SAVE_REPORT') || 'false'

gradlew_folder_path = if Pathname.new(ac_project_path.to_s).absolute?
                        ac_project_path
                      else
                        File.expand_path(File.join(ac_repo_path, ac_project_path))
                      end

command = "cd #{gradlew_folder_path} && chmod +x ./gradlew && ./gradlew #{task} #{extra}"
status = run_command(command)
if save_report == 'true'
  ac_output_path = get_env_variable('AC_OUTPUT_DIR') || abort('Missing output path.')
  ac_module = get_env_variable('AC_MODULE')
  destination = (Pathname.new ac_output_path).join('detekt_output')
  source = File.join(gradlew_folder_path, "#{ac_module}/build/reports")
  puts "Copying reports from #{source} to #{destination}"
  FileUtils.copy_entry source, destination
end

raise 'Detekt failed!' unless status
