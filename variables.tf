variable "aks_cluster_name" {
    type = string
    description = "AKS Cluster Name"
}

variable "aks_cluster_location" {
  type = string
  default = "westeurope"
  description = "Location where cluster will de deploy"
}

variable "aks_resource_group_name" {
  type = string
  description = "Resource group where cluster will de deploy"
}

variable "product_name" {
  type        = string
  default     = ""
  description = "The product which this resouce bellong and which will be used to identfy it."
  nullable    = false
}

variable "agents_labels" {
  type        = map(string)
  default     = {}
  description = "(Optional) A map of Kubernetes labels which should be applied to nodes in the Default Node Pool. Changing this forces a new resource to be created."
}

variable "pod_subnet_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Subnet where the pods in the default Node Pool should exist. Changing this forces a new resource to be created."
}

variable "temporary_name_for_rotation" {
  type        = string
  default     = null
  description = "(Optional) Specifies the name of the temporary node pool used to cycle the default node pool for VM resizing. the `var.agents_size` is no longer ForceNew and can be resized by specifying `temporary_name_for_rotation`"
}

variable "enable_node_public_ip" {
  type        = bool
  default     = true
  description = "(Optional) Should nodes in this Node Pool have a Public IP Address? Defaults to false."
}

variable "agents_max_pods" {
  type        = number
  default     = null
  description = "(Optional) The maximum number of pods that can run on each agent. Changing this forces a new resource to be created."
}

variable "os_disk_size_gb" {
  type        = number
  default     = 128
  description = "Disk size of nodes in GBs."
}

variable "agents_type" {
  type        = string
  default     = "VirtualMachineScaleSets"
  description = "(Optional) The type of Node Pool which should be created. Possible values are AvailabilitySet and VirtualMachineScaleSets. Defaults to VirtualMachineScaleSets."
}

variable "enable_auto_scaling" {
  type        = bool
  default     = true
  description = "Enable node pool autoscaling"
}

variable "os_disk_type" {
  type        = string
  default     = "Managed"
  description = "The type of disk which should be used for the Operating System. Possible values are `Ephemeral` and `Managed`. Defaults to `Managed`. Changing this forces a new resource to be created."
  nullable    = false
}

variable "os_sku" {
  type        = string
  default     = null
  description = "(Optional) Specifies the OS SKU used by the agent pool. Possible values include: `Ubuntu`, `CBLMariner`, `Mariner`, `Windows2019`, `Windows2022`. If not specified, the default is `Ubuntu` if OSType=Linux or `Windows2019` if OSType=Windows. And the default Windows OSSKU will be changed to `Windows2022` after Windows2019 is deprecated. Changing this forces a new resource to be created."
}

variable "max_count" {
  type        = number
  default     = 3
  description = "Maximum number of nodes in a pool"
}

variable "min_count" {
  type        = number
  default     = 1
  description = "Minimum number of nodes in a pool"
}

variable "node_count" {
  type        = number
  default     = 1
  description = "The number of Agents that should exist in the Agent Pool."
}

variable "node_pool_vm_size" {
  type        = string
  default     = "Standard_D2s_v3"
  description = "The default virtual machine size for the Kubernetes agents."
}

variable "node_pool_name" {
  type        = string
  default     = "nodepool"
  description = "The default Azure AKS nodepool name."
  nullable    = false
}

variable "identity_type" {
  type        = string
  default     = "SystemAssigned"
  description = "The type of identity used for the managed cluster. At this time the only supported value is SystemAssigned"

  validation {
    condition     = var.identity_type == "SystemAssigned"
    error_message = "`identity_type`'s the only supported value is `SystemAssigned`"
  }
}

variable "kubernetes_version" {
  type        = string
  default     = null
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
}

variable "private_cluster_enabled" {
  type        = bool
  default     = false
  description = "If true cluster API server will be exposed only on internal IP address and available only in cluster vnet."
}

variable "http_application_routing_enabled" {
  type        = bool
  default     = false
  description = "Enable HTTP Application Routing Addon (forces recreation)."
}

variable "node_resource_group" {
  type        = string
  default     = null
  description = "The auto-generated Resource Group which contains the resources for this Managed Kubernetes Cluster. Changing this forces a new resource to be created."
}

variable "agents_count" {
  type        = number
  default     = 2
  description = "The number of Agents that should exist in the Agent Pool. Please set `agents_count` `null` while `enable_auto_scaling` is `true` to avoid possible `agents_count` changes."
}

variable "agents_taints" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of the taints added to new nodes during node pool create and scale. Changing this forces a new resource to be created."
}

variable "orchestrator_version" {
  type        = string
  default     = null
  description = "Specify which Kubernetes release to use for the orchestration layer. The default used is the latest Kubernetes version available in the region"
}


variable "vnet_subnet_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of a Subnet where the Kubernetes Node Pool should exist. Changing this forces a new resource to be created."
}

variable "ultra_ssd_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Used to specify whether the UltraSSD is enabled in the Default Node Pool. Defaults to false."
}

variable "scale_down_mode" {
  type        = string
  default     = "Delete"
  description = "(Optional) Specifies the autoscaling behaviour of the Kubernetes Cluster. If not specified, it defaults to `Delete`. Possible values include `Delete` and `Deallocate`. Changing this forces a new resource to be created."
}

variable "agents_availability_zones" {
  type        = list(string)
  default     = null
  description = "(Optional) A list of Availability Zones across which the Node Pool should be spread. Changing this forces a new resource to be created."
}

variable "local_account_disabled" {
  type        = bool
  default     = null
  description = "(Optional) - If `true` local accounts will be disabled. Defaults to `false`. See [the documentation](https://docs.microsoft.com/azure/aks/managed-aad#disable-local-accounts) for more information."
}

variable "automatic_channel_upgrade" {
  type        = string
  default     = null
  description = "(Optional) The upgrade channel for this Kubernetes Cluster. Possible values are `patch`, `rapid`, `node-image` and `stable`. By default automatic-upgrades are turned off. Note that you cannot specify the patch version using `kubernetes_version` or `orchestrator_version` when using the `patch` upgrade channel. See [the documentation](https://learn.microsoft.com/en-us/azure/aks/auto-upgrade-cluster) for more information"

  validation {
    condition = var.automatic_channel_upgrade == null ? true : contains([
      "patch", "stable", "rapid", "node-image"
    ], var.automatic_channel_upgrade)
    error_message = "`automatic_channel_upgrade`'s possible values are `patch`, `stable`, `rapid` or `node-image`."
  }
}

variable "azure_policy_enabled" {
  type        = bool
  default     = false
  description = "Enable Azure Policy Addon."
}

variable "disk_encryption_set_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Disk Encryption Set which should be used for the Nodes and Volumes. More information [can be found in the documentation](https://docs.microsoft.com/azure/aks/azure-disk-customer-managed-keys). Changing this forces a new resource to be created."
}

variable "oidc_issuer_enabled" {
  type        = bool
  default     = false
  description = "Enable or Disable the OIDC issuer URL. Defaults to false."
}

variable "open_service_mesh_enabled" {
  type        = bool
  default     = null
  description = "Is Open Service Mesh enabled? For more details, please visit [Open Service Mesh for AKS](https://docs.microsoft.com/azure/aks/open-service-mesh-about)."
}

variable "private_cluster_public_fqdn_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Specifies whether a Public FQDN for this Private Cluster should be added. Defaults to `false`."
}

variable "private_dns_zone_id" {
  type        = string
  default     = null
  description = "(Optional) Either the ID of Private DNS Zone which should be delegated to this Cluster, `System` to have AKS manage this or `None`. In case of `None` you will need to bring your own DNS server and set up resolving, otherwise cluster will have issues after provisioning. Changing this forces a new resource to be created."
}

variable "public_network_access_enabled" {
  type        = bool
  default     = true
  description = "(Optional) Whether public network access is allowed for this Kubernetes Cluster. Defaults to `true`. Changing this forces a new resource to be created."
  nullable    = false
}

variable "role_based_access_control_enabled" {
  type        = bool
  default     = true
  description = "Enable Role Based Access Control."
  nullable    = false
}

variable "sku_tier" {
  type        = string
  default     = "Standard"
  description = "The SKU Tier that should be used for this Kubernetes Cluster. Possible values are `Free` and `Standard`"

  validation {
    condition     = contains(["Free", "Standard"], var.sku_tier)
    error_message = "The SKU Tier must be either `Free` or `Standard`. `Paid` is no longer supported since AzureRM provider v3.51.0."
  }
}

variable "workload_identity_enabled" {
  type        = bool
  default     = false
  description = "Enable or Disable Workload Identity. Defaults to false."
}

variable "agents_pool_kubelet_configs" {
  type = list(object({
    cpu_manager_policy        = optional(string)
    cpu_cfs_quota_enabled     = optional(bool, true)
    cpu_cfs_quota_period      = optional(string)
    image_gc_high_threshold   = optional(number)
    image_gc_low_threshold    = optional(number)
    topology_manager_policy   = optional(string)
    allowed_unsafe_sysctls    = optional(set(string))
    container_log_max_size_mb = optional(number)
    container_log_max_line    = optional(number)
    pod_max_pid               = optional(number)
  }))
  default     = []
  description = <<-EOT
    list(object({
      cpu_manager_policy        = (Optional) Specifies the CPU Manager policy to use. Possible values are `none` and `static`, Changing this forces a new resource to be created.
      cpu_cfs_quota_enabled     = (Optional) Is CPU CFS quota enforcement for containers enabled? Changing this forces a new resource to be created.
      cpu_cfs_quota_period      = (Optional) Specifies the CPU CFS quota period value. Changing this forces a new resource to be created.
      image_gc_high_threshold   = (Optional) Specifies the percent of disk usage above which image garbage collection is always run. Must be between `0` and `100`. Changing this forces a new resource to be created.
      image_gc_low_threshold    = (Optional) Specifies the percent of disk usage lower than which image garbage collection is never run. Must be between `0` and `100`. Changing this forces a new resource to be created.
      topology_manager_policy   = (Optional) Specifies the Topology Manager policy to use. Possible values are `none`, `best-effort`, `restricted` or `single-numa-node`. Changing this forces a new resource to be created.
      allowed_unsafe_sysctls    = (Optional) Specifies the allow list of unsafe sysctls command or patterns (ending in `*`). Changing this forces a new resource to be created.
      container_log_max_size_mb = (Optional) Specifies the maximum size (e.g. 10MB) of container log file before it is rotated. Changing this forces a new resource to be created.
      container_log_max_line    = (Optional) Specifies the maximum number of container log files that can be present for a container. must be at least 2. Changing this forces a new resource to be created.
      pod_max_pid               = (Optional) Specifies the maximum number of processes per pod. Changing this forces a new resource to be created.
  }))
EOT
  nullable    = false
}


variable "agents_pool_linux_os_configs" {
  type = list(object({
    sysctl_configs = optional(list(object({
      fs_aio_max_nr                      = optional(number)
      fs_file_max                        = optional(number)
      fs_inotify_max_user_watches        = optional(number)
      fs_nr_open                         = optional(number)
      kernel_threads_max                 = optional(number)
      net_core_netdev_max_backlog        = optional(number)
      net_core_optmem_max                = optional(number)
      net_core_rmem_default              = optional(number)
      net_core_rmem_max                  = optional(number)
      net_core_somaxconn                 = optional(number)
      net_core_wmem_default              = optional(number)
      net_core_wmem_max                  = optional(number)
      net_ipv4_ip_local_port_range_min   = optional(number)
      net_ipv4_ip_local_port_range_max   = optional(number)
      net_ipv4_neigh_default_gc_thresh1  = optional(number)
      net_ipv4_neigh_default_gc_thresh2  = optional(number)
      net_ipv4_neigh_default_gc_thresh3  = optional(number)
      net_ipv4_tcp_fin_timeout           = optional(number)
      net_ipv4_tcp_keepalive_intvl       = optional(number)
      net_ipv4_tcp_keepalive_probes      = optional(number)
      net_ipv4_tcp_keepalive_time        = optional(number)
      net_ipv4_tcp_max_syn_backlog       = optional(number)
      net_ipv4_tcp_max_tw_buckets        = optional(number)
      net_ipv4_tcp_tw_reuse              = optional(bool)
      net_netfilter_nf_conntrack_buckets = optional(number)
      net_netfilter_nf_conntrack_max     = optional(number)
      vm_max_map_count                   = optional(number)
      vm_swappiness                      = optional(number)
      vm_vfs_cache_pressure              = optional(number)
    })), [])
    transparent_huge_page_enabled = optional(string)
    transparent_huge_page_defrag  = optional(string)
    swap_file_size_mb             = optional(number)
  }))
  default     = []
  description = <<-EOT
  list(object({
    sysctl_configs = optional(list(object({
      fs_aio_max_nr                      = (Optional) The sysctl setting fs.aio-max-nr. Must be between `65536` and `6553500`. Changing this forces a new resource to be created.
      fs_file_max                        = (Optional) The sysctl setting fs.file-max. Must be between `8192` and `12000500`. Changing this forces a new resource to be created.
      fs_inotify_max_user_watches        = (Optional) The sysctl setting fs.inotify.max_user_watches. Must be between `781250` and `2097152`. Changing this forces a new resource to be created.
      fs_nr_open                         = (Optional) The sysctl setting fs.nr_open. Must be between `8192` and `20000500`. Changing this forces a new resource to be created.
      kernel_threads_max                 = (Optional) The sysctl setting kernel.threads-max. Must be between `20` and `513785`. Changing this forces a new resource to be created.
      net_core_netdev_max_backlog        = (Optional) The sysctl setting net.core.netdev_max_backlog. Must be between `1000` and `3240000`. Changing this forces a new resource to be created.
      net_core_optmem_max                = (Optional) The sysctl setting net.core.optmem_max. Must be between `20480` and `4194304`. Changing this forces a new resource to be created.
      net_core_rmem_default              = (Optional) The sysctl setting net.core.rmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
      net_core_rmem_max                  = (Optional) The sysctl setting net.core.rmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
      net_core_somaxconn                 = (Optional) The sysctl setting net.core.somaxconn. Must be between `4096` and `3240000`. Changing this forces a new resource to be created.
      net_core_wmem_default              = (Optional) The sysctl setting net.core.wmem_default. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
      net_core_wmem_max                  = (Optional) The sysctl setting net.core.wmem_max. Must be between `212992` and `134217728`. Changing this forces a new resource to be created.
      net_ipv4_ip_local_port_range_min   = (Optional) The sysctl setting net.ipv4.ip_local_port_range max value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.
      net_ipv4_ip_local_port_range_max   = (Optional) The sysctl setting net.ipv4.ip_local_port_range min value. Must be between `1024` and `60999`. Changing this forces a new resource to be created.
      net_ipv4_neigh_default_gc_thresh1  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh1. Must be between `128` and `80000`. Changing this forces a new resource to be created.
      net_ipv4_neigh_default_gc_thresh2  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh2. Must be between `512` and `90000`. Changing this forces a new resource to be created.
      net_ipv4_neigh_default_gc_thresh3  = (Optional) The sysctl setting net.ipv4.neigh.default.gc_thresh3. Must be between `1024` and `100000`. Changing this forces a new resource to be created.
      net_ipv4_tcp_fin_timeout           = (Optional) The sysctl setting net.ipv4.tcp_fin_timeout. Must be between `5` and `120`. Changing this forces a new resource to be created.
      net_ipv4_tcp_keepalive_intvl       = (Optional) The sysctl setting net.ipv4.tcp_keepalive_intvl. Must be between `10` and `75`. Changing this forces a new resource to be created.
      net_ipv4_tcp_keepalive_probes      = (Optional) The sysctl setting net.ipv4.tcp_keepalive_probes. Must be between `1` and `15`. Changing this forces a new resource to be created.
      net_ipv4_tcp_keepalive_time        = (Optional) The sysctl setting net.ipv4.tcp_keepalive_time. Must be between `30` and `432000`. Changing this forces a new resource to be created.
      net_ipv4_tcp_max_syn_backlog       = (Optional) The sysctl setting net.ipv4.tcp_max_syn_backlog. Must be between `128` and `3240000`. Changing this forces a new resource to be created.
      net_ipv4_tcp_max_tw_buckets        = (Optional) The sysctl setting net.ipv4.tcp_max_tw_buckets. Must be between `8000` and `1440000`. Changing this forces a new resource to be created.
      net_ipv4_tcp_tw_reuse              = (Optional) The sysctl setting net.ipv4.tcp_tw_reuse. Changing this forces a new resource to be created.
      net_netfilter_nf_conntrack_buckets = (Optional) The sysctl setting net.netfilter.nf_conntrack_buckets. Must be between `65536` and `147456`. Changing this forces a new resource to be created.
      net_netfilter_nf_conntrack_max     = (Optional) The sysctl setting net.netfilter.nf_conntrack_max. Must be between `131072` and `1048576`. Changing this forces a new resource to be created.
      vm_max_map_count                   = (Optional) The sysctl setting vm.max_map_count. Must be between `65530` and `262144`. Changing this forces a new resource to be created.
      vm_swappiness                      = (Optional) The sysctl setting vm.swappiness. Must be between `0` and `100`. Changing this forces a new resource to be created.
      vm_vfs_cache_pressure              = (Optional) The sysctl setting vm.vfs_cache_pressure. Must be between `0` and `100`. Changing this forces a new resource to be created.
    })), [])
    transparent_huge_page_enabled = (Optional) Specifies the Transparent Huge Page enabled configuration. Possible values are `always`, `madvise` and `never`. Changing this forces a new resource to be created.
    transparent_huge_page_defrag  = (Optional) specifies the defrag configuration for Transparent Huge Page. Possible values are `always`, `defer`, `defer+madvise`, `madvise` and `never`. Changing this forces a new resource to be created.
    swap_file_size_mb             = (Optional) Specifies the size of the swap file on each node in MB. Changing this forces a new resource to be created.
  }))
EOT
  nullable    = false
}

variable "agents_pool_max_surge" {
  type        = string
  default     = null
  description = "The maximum number or percentage of nodes which will be added to the Default Node Pool size during an upgrade."
}

variable "aci_connector_linux_enabled" {
  type        = bool
  default     = false
  description = "Enable Virtual Node pool"
}

variable "api_server_authorized_ip_ranges" {
  type        = set(string)
  default     = null
  description = "(Optional) The IP ranges to allow for incoming traffic to the server nodes."
}

variable "api_server_subnet_id" {
  type        = string
  default     = null
  description = "(Optional) The ID of the Subnet where the API server endpoint is delegated to."
}

variable "auto_scaler_profile_enabled" {
  type        = bool
  default     = false
  description = "Enable configuring the auto scaler profile"
  nullable    = false
}

variable "auto_scaler_profile_balance_similar_node_groups" {
  type        = bool
  default     = false
  description = "Detect similar node groups and balance the number of nodes between them. Defaults to `false`."
}

variable "auto_scaler_profile_empty_bulk_delete_max" {
  type        = number
  default     = 10
  description = "Maximum number of empty nodes that can be deleted at the same time. Defaults to `10`."
}

variable "auto_scaler_profile_expander" {
  type        = string
  default     = "random"
  description = "Expander to use. Possible values are `least-waste`, `priority`, `most-pods` and `random`. Defaults to `random`."

  validation {
    condition     = contains(["least-waste", "most-pods", "priority", "random"], var.auto_scaler_profile_expander)
    error_message = "Must be either `least-waste`, `most-pods`, `priority` or `random`."
  }
}

variable "auto_scaler_profile_max_graceful_termination_sec" {
  type        = string
  default     = "600"
  description = "Maximum number of seconds the cluster autoscaler waits for pod termination when trying to scale down a node. Defaults to `600`."
}

variable "auto_scaler_profile_max_node_provisioning_time" {
  type        = string
  default     = "15m"
  description = "Maximum time the autoscaler waits for a node to be provisioned. Defaults to `15m`."
}

variable "auto_scaler_profile_max_unready_nodes" {
  type        = number
  default     = 3
  description = "Maximum Number of allowed unready nodes. Defaults to `3`."
}

variable "auto_scaler_profile_max_unready_percentage" {
  type        = number
  default     = 45
  description = "Maximum percentage of unready nodes the cluster autoscaler will stop if the percentage is exceeded. Defaults to `45`."
}

variable "auto_scaler_profile_new_pod_scale_up_delay" {
  type        = string
  default     = "10s"
  description = "For scenarios like burst/batch scale where you don't want CA to act before the kubernetes scheduler could schedule all the pods, you can tell CA to ignore unscheduled pods before they're a certain age. Defaults to `10s`."
}

variable "auto_scaler_profile_scale_down_delay_after_add" {
  type        = string
  default     = "10m"
  description = "How long after the scale up of AKS nodes the scale down evaluation resumes. Defaults to `10m`."
}

variable "auto_scaler_profile_scale_down_delay_after_delete" {
  type        = string
  default     = null
  description = "How long after node deletion that scale down evaluation resumes. Defaults to the value used for `scan_interval`."
}

variable "auto_scaler_profile_scale_down_delay_after_failure" {
  type        = string
  default     = "3m"
  description = "How long after scale down failure that scale down evaluation resumes. Defaults to `3m`."
}

variable "auto_scaler_profile_scale_down_unneeded" {
  type        = string
  default     = "10m"
  description = "How long a node should be unneeded before it is eligible for scale down. Defaults to `10m`."
}

variable "auto_scaler_profile_scale_down_unready" {
  type        = string
  default     = "20m"
  description = "How long an unready node should be unneeded before it is eligible for scale down. Defaults to `20m`."
}


variable "auto_scaler_profile_scale_down_utilization_threshold" {
  type        = string
  default     = "0.5"
  description = "Node utilization level, defined as sum of requested resources divided by capacity, below which a node can be considered for scale down. Defaults to `0.5`."
}

variable "auto_scaler_profile_scan_interval" {
  type        = string
  default     = "10s"
  description = "How often the AKS Cluster should be re-evaluated for scale up/down. Defaults to `10s`."
}

variable "auto_scaler_profile_skip_nodes_with_local_storage" {
  type        = bool
  default     = true
  description = "If `true` cluster autoscaler will never delete nodes with pods with local storage, for example, EmptyDir or HostPath. Defaults to `true`."
}

variable "auto_scaler_profile_skip_nodes_with_system_pods" {
  type        = bool
  default     = true
  description = "If `true` cluster autoscaler will never delete nodes with pods from kube-system (except for DaemonSet or mirror pods). Defaults to `true`."
}

variable "rbac_aad" {
  type        = bool
  default     = false
  description = "(Optional) Is Azure Active Directory integration enabled?"
  nullable    = false
}

variable "rbac_aad_managed" {
  type        = bool
  default     = false
  description = "Is the Azure Active Directory integration Managed, meaning that Azure will create/manage the Service Principal used for integration."
  nullable    = false
}

variable "rbac_aad_admin_group_object_ids" {
  type        = list(string)
  default     = null
  description = "Object ID of groups with admin access."
}

variable "rbac_aad_azure_rbac_enabled" {
  type        = bool
  default     = null
  description = "(Optional) Is Role Based Access Control based on Azure AD enabled?"
}

variable "rbac_aad_tenant_id" {
  type        = string
  default     = null
  description = "(Optional) The Tenant ID used for Azure Active Directory Application. If this isn't specified the Tenant ID of the current Subscription is used."
}


variable "rbac_aad_client_app_id" {
  type        = string
  default     = null
  description = "The Client ID of an Azure Active Directory Application."
}

variable "rbac_aad_server_app_id" {
  type        = string
  default     = null
  description = "The Server ID of an Azure Active Directory Application."
}

variable "rbac_aad_server_app_secret" {
  type        = string
  default     = null
  description = "The Server Secret of an Azure Active Directory Application."
}

variable "admin_username" {
  type        = string
  default     = null
  description = "The username of the local administrator to be created on the Kubernetes cluster. Set this variable to `null` to turn off the cluster's `linux_profile`. Changing this forces a new resource to be created."
}

variable "public_ssh_key" {
  type        = string
  default     = ""
  description = "A custom ssh key to control access to the AKS cluster. Changing this forces a new resource to be created."
}

variable "maintenance_window" {
  type = object({
    allowed = list(object({
      day   = string
      hours = set(number)
    })),
    not_allowed = list(object({
      end   = string
      start = string
    })),
  })
  default     = null
  description = "(Optional) Maintenance configuration of the managed cluster."
}

variable "microsoft_defender_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Is Microsoft Defender on the cluster enabled? Requires `var.log_analytics_workspace_enabled` to be `true` to set this variable to `true`."
  nullable    = false
}

variable "monitor_metrics" {
  type = object({
    annotations_allowed = optional(string)
    labels_allowed      = optional(string)
  })
  default     = null
  description = <<-EOT
  (Optional) Specifies a Prometheus add-on profile for the Kubernetes Cluster
  object({
    annotations_allowed = "(Optional) Specifies a comma-separated list of Kubernetes annotation keys that will be used in the resource's labels metric."
    labels_allowed      = "(Optional) Specifies a Comma-separated list of additional Kubernetes label keys that will be used in the resource's labels metric."
  })
EOT
}

variable "network_plugin" {
  type        = string
  default     = "kubenet"
  description = "Network plugin to use for networking."
  nullable    = false
}

variable "net_profile_dns_service_ip" {
  type        = string
  default     = null
  description = "(Optional) IP address within the Kubernetes service address range that will be used by cluster service discovery (kube-dns). Changing this forces a new resource to be created."
}

variable "ebpf_data_plane" {
  type        = string
  default     = null
  description = "(Optional) Specifies the eBPF data plane used for building the Kubernetes network. Possible value is `cilium`. Changing this forces a new resource to be created."
}

variable "load_balancer_sku" {
  type        = string
  default     = "standard"
  description = "(Optional) Specifies the SKU of the Load Balancer used for this Kubernetes Cluster. Possible values are `basic` and `standard`. Defaults to `standard`. Changing this forces a new kubernetes cluster to be created."

  validation {
    condition     = contains(["basic", "standard"], var.load_balancer_sku)
    error_message = "Possible values are `basic` and `standard`"
  }
}

variable "network_plugin_mode" {
  type        = string
  default     = null
  description = "(Optional) Specifies the network plugin mode used for building the Kubernetes network. Possible value is `Overlay`. Changing this forces a new resource to be created."
}

variable "network_policy" {
  type        = string
  default     = null
  description = " (Optional) Sets up network policy to be used with Azure CNI. Network policy allows us to control the traffic flow between pods. Currently supported values are calico and azure. Changing this forces a new resource to be created."
}

variable "net_profile_outbound_type" {
  type        = string
  default     = "loadBalancer"
  description = "(Optional) The outbound (egress) routing method which should be used for this Kubernetes Cluster. Possible values are loadBalancer and userDefinedRouting. Defaults to loadBalancer."
}

variable "net_profile_pod_cidr" {
  type        = string
  default     = null
  description = " (Optional) The CIDR to use for pod IP addresses. This field can only be set when network_plugin is set to kubenet. Changing this forces a new resource to be created."
}

variable "net_profile_service_cidr" {
  type        = string
  default     = null
  description = "(Optional) The Network Range used by the Kubernetes service. Changing this forces a new resource to be created."
}

variable "load_balancer_profile_enabled" {
  type        = bool
  default     = false
  description = "(Optional) Enable a load_balancer_profile block. This can only be used when load_balancer_sku is set to `standard`."
  nullable    = false
}

variable "load_balancer_profile_idle_timeout_in_minutes" {
  type        = number
  default     = 30
  description = "(Optional) Desired outbound flow idle timeout in minutes for the cluster load balancer. Must be between `4` and `120` inclusive."
}

variable "load_balancer_profile_managed_outbound_ip_count" {
  type        = number
  default     = null
  description = "(Optional) Count of desired managed outbound IPs for the cluster load balancer. Must be between `1` and `100` inclusive"
}

variable "load_balancer_profile_managed_outbound_ipv6_count" {
  type        = number
  default     = null
  description = "(Optional) The desired number of IPv6 outbound IPs created and managed by Azure for the cluster load balancer. Must be in the range of `1` to `100` (inclusive). The default value is `0` for single-stack and `1` for dual-stack. Note: managed_outbound_ipv6_count requires dual-stack networking. To enable dual-stack networking the Preview Feature Microsoft.ContainerService/AKS-EnableDualStack needs to be enabled and the Resource Provider re-registered, see the documentation for more information. https://learn.microsoft.com/en-us/azure/aks/configure-kubenet-dual-stack?tabs=azure-cli%2Ckubectl#register-the-aks-enabledualstack-preview-feature"
}

variable "load_balancer_profile_outbound_ip_address_ids" {
  type        = set(string)
  default     = null
  description = "(Optional) The ID of the Public IP Addresses which should be used for outbound communication for the cluster load balancer."
}

variable "load_balancer_profile_outbound_ip_prefix_ids" {
  type        = set(string)
  default     = null
  description = "(Optional) The ID of the outbound Public IP Address Prefixes which should be used for the cluster load balancer."
}

variable "load_balancer_profile_outbound_ports_allocated" {
  type        = number
  default     = 0
  description = "(Optional) Number of desired SNAT port for each VM in the clusters load balancer. Must be between `0` and `64000` inclusive. Defaults to `0`"
}

variable "client_id" {
  type        = string
  default     = ""
  description = "(Optional) The Client ID (appId) for the Service Principal used for the AKS deployment"
  nullable    = false
}

variable "client_secret" {
  type        = string
  default     = ""
  description = "(Optional) The Client Secret (password) for the Service Principal used for the AKS deployment"
  nullable    = false
}

variable "identity_ids" {
  type        = list(string)
  default     = null
  description = "(Optional) Specifies a list of User Assigned Managed Identity IDs to be assigned to this Kubernetes Cluster."
}

variable "attached_acr_id_map" {
  type        = map(string)
  default     = {}
  description = "Azure Container Registry ids that need an authentication mechanism with Azure Kubernetes Service (AKS). Map key must be static string as acr's name, the value is acr's resource id. Changing this forces some new resources to be created."
  nullable    = false
}

