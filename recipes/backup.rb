node.set["percona"]["backup"]["configure"] = true

include_recipe "percona::package_repo"

case node["platform_family"]
when "debian"
  if node['platform'] == "ubuntu" && node['platform_version'].to_f < 13.04
    package "xtrabackup" do
      options "--force-yes"
    end
  else
    package "percona-xtrabackup" do
      options "--force-yes"
    end
  end
when "rhel"
  package "percona-xtrabackup"
end

# access grants
include_recipe "percona::access_grants"
