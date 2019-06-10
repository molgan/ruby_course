require 'yaml'

module Storage
    def save_yml(resourse, file)
        File.open(file, 'w') { |f| YAML.dump(resourse, f) }
    end

    def load_yml(file)
        YAML.load(File.open(file)) if File.exist?(file)
    end
end