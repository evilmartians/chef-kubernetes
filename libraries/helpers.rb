class Chef
  class Recipe
    def internal_ip(n = node)
      n.send(:network)[:interfaces][n['kubernetes']['interface']]['addresses']
        .find {|addr, properties| properties['family'] == 'inet'}.first rescue ''
    end

    def hostname(n = node)
      n.send(:kubernetes)[:register_as] == 'ip' ? internal_ip(n) : n.send(:hostname)
    end

    def weave_images
      %w(weave weaveexec plugin).map {|image| "weaveworks/#{image}:#{node[:kubernetes][:weave][:version]}"}
    end

    def weave_works?
      weave_images.all? {|c| system("docker ps|grep '#{c}' >/dev/null 2>&1")}
    end

    def weavedb_downloaded?
      system("docker images weaveworks/weavedb:latest|grep 'latest' >/dev/null 2>&1")
    end

    def weave_images_downloaded?
      weave_images.all? { |image| system("docker images #{image}|grep '#{node[:kubernetes][:weave][:version]}' >/dev/null 2>&1") }
    end
  end
end
