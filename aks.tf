resource "azurerm_kubernetes_cluster" "aks_cluster" {
  #name                                  = coalesce(var.aks_cluster_name, trim("${var.product_name}-aks", "-"))
  name                                = var.aks_cluster_name
  location                            = var.aks_cluster_location
  resource_group_name                 = var.aks_resource_group_name
  automatic_channel_upgrade           = var.automatic_channel_upgrade
  azure_policy_enabled                = var.azure_policy_enabled
  disk_encryption_set_id              = var.disk_encryption_set_id
  dns_prefix                          = local.dns_prefix
  http_application_routing_enabled    = var.http_application_routing_enabled
  local_account_disabled              = var.local_account_disabled
  kubernetes_version                  = var.kubernetes_version
  node_resource_group                 = var.node_resource_group
  oidc_issuer_enabled                 = var.oidc_issuer_enabled
  open_service_mesh_enabled           = var.open_service_mesh_enabled
  private_cluster_enabled             = var.private_cluster_enabled
  private_cluster_public_fqdn_enabled = var.private_cluster_public_fqdn_enabled
  private_dns_zone_id                 = var.private_dns_zone_id
  public_network_access_enabled       = var.public_network_access_enabled
  role_based_access_control_enabled   = var.role_based_access_control_enabled
  sku_tier                            = var.sku_tier
  workload_identity_enabled           = var.workload_identity_enabled


  dynamic "default_node_pool" {
    for_each = var.enable_auto_scaling == true ? ["default_node_pool_auto_scaled"] : []
    content {
      name                        = var.node_pool_name
      vm_size                     = var.node_pool_vm_size
      enable_auto_scaling         = var.enable_auto_scaling
      enable_node_public_ip       = var.enable_node_public_ip
      max_count                   = var.max_count
      min_count                   = var.min_count
      max_pods                    = var.agents_max_pods
      node_labels                 = var.agents_labels
      node_taints                 = var.agents_taints
      orchestrator_version        = var.orchestrator_version
      os_disk_size_gb             = var.os_disk_size_gb
      os_disk_type                = var.os_disk_type
      os_sku                      = var.os_sku
      pod_subnet_id               = var.pod_subnet_id
      scale_down_mode             = var.scale_down_mode
      temporary_name_for_rotation = var.temporary_name_for_rotation
      type                        = var.agents_type
      ultra_ssd_enabled           = var.ultra_ssd_enabled
      vnet_subnet_id              = var.vnet_subnet_id
      zones                       = var.agents_availability_zones
      node_count                  = var.agents_count



      dynamic "kubelet_config" {
        for_each = var.agents_pool_kubelet_configs

        content {
          allowed_unsafe_sysctls    = kubelet_config.value.allowed_unsafe_sysctls
          container_log_max_line    = kubelet_config.value.container_log_max_line
          container_log_max_size_mb = kubelet_config.value.container_log_max_size_mb
          cpu_cfs_quota_enabled     = kubelet_config.value.cpu_cfs_quota_enabled
          cpu_cfs_quota_period      = kubelet_config.value.cpu_cfs_quota_period
          cpu_manager_policy        = kubelet_config.value.cpu_manager_policy
          image_gc_high_threshold   = kubelet_config.value.image_gc_high_threshold
          image_gc_low_threshold    = kubelet_config.value.image_gc_low_threshold
          pod_max_pid               = kubelet_config.value.pod_max_pid
          topology_manager_policy   = kubelet_config.value.topology_manager_policy
        }
      }


      dynamic "linux_os_config" {
        for_each = var.agents_pool_linux_os_configs

        content {
          swap_file_size_mb             = linux_os_config.value.swap_file_size_mb
          transparent_huge_page_defrag  = linux_os_config.value.transparent_huge_page_defrag
          transparent_huge_page_enabled = linux_os_config.value.transparent_huge_page_enabled

          dynamic "sysctl_config" {
            for_each = linux_os_config.value.sysctl_configs == null ? [] : linux_os_config.value.sysctl_configs

            content {
              fs_aio_max_nr                      = sysctl_config.value.fs_aio_max_nr
              fs_file_max                        = sysctl_config.value.fs_file_max
              fs_inotify_max_user_watches        = sysctl_config.value.fs_inotify_max_user_watches
              fs_nr_open                         = sysctl_config.value.fs_nr_open
              kernel_threads_max                 = sysctl_config.value.kernel_threads_max
              net_core_netdev_max_backlog        = sysctl_config.value.net_core_netdev_max_backlog
              net_core_optmem_max                = sysctl_config.value.net_core_optmem_max
              net_core_rmem_default              = sysctl_config.value.net_core_rmem_default
              net_core_rmem_max                  = sysctl_config.value.net_core_rmem_max
              net_core_somaxconn                 = sysctl_config.value.net_core_somaxconn
              net_core_wmem_default              = sysctl_config.value.net_core_wmem_default
              net_core_wmem_max                  = sysctl_config.value.net_core_wmem_max
              net_ipv4_ip_local_port_range_max   = sysctl_config.value.net_ipv4_ip_local_port_range_max
              net_ipv4_ip_local_port_range_min   = sysctl_config.value.net_ipv4_ip_local_port_range_min
              net_ipv4_neigh_default_gc_thresh1  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh1
              net_ipv4_neigh_default_gc_thresh2  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh2
              net_ipv4_neigh_default_gc_thresh3  = sysctl_config.value.net_ipv4_neigh_default_gc_thresh3
              net_ipv4_tcp_fin_timeout           = sysctl_config.value.net_ipv4_tcp_fin_timeout
              net_ipv4_tcp_keepalive_intvl       = sysctl_config.value.net_ipv4_tcp_keepalive_intvl
              net_ipv4_tcp_keepalive_probes      = sysctl_config.value.net_ipv4_tcp_keepalive_probes
              net_ipv4_tcp_keepalive_time        = sysctl_config.value.net_ipv4_tcp_keepalive_time
              net_ipv4_tcp_max_syn_backlog       = sysctl_config.value.net_ipv4_tcp_max_syn_backlog
              net_ipv4_tcp_max_tw_buckets        = sysctl_config.value.net_ipv4_tcp_max_tw_buckets
              net_ipv4_tcp_tw_reuse              = sysctl_config.value.net_ipv4_tcp_tw_reuse
              net_netfilter_nf_conntrack_buckets = sysctl_config.value.net_netfilter_nf_conntrack_buckets
              net_netfilter_nf_conntrack_max     = sysctl_config.value.net_netfilter_nf_conntrack_max
              vm_max_map_count                   = sysctl_config.value.vm_max_map_count
              vm_swappiness                      = sysctl_config.value.vm_swappiness
              vm_vfs_cache_pressure              = sysctl_config.value.vm_vfs_cache_pressure
            }
          }
        }
      }

      dynamic "upgrade_settings" {
        for_each = var.agents_pool_max_surge == null ? [] : ["upgrade_settings"]

        content {
          max_surge = var.agents_pool_max_surge
        }
      }

    }

  }

  dynamic "aci_connector_linux" {
    for_each = var.aci_connector_linux_enabled ? ["aci_connector_linux"] : []

    content {
      subnet_name = var.aci_connector_linux_subnet_name
    }
  }

  dynamic "key_vault_secrets_provider" {
    for_each = var.key_vault_secrets_provider_enabled ? ["key_vault_secrets_provider"] : []

    content {
      secret_rotation_enabled  = var.key_vault_secrets_provider_enabled
      secret_rotation_interval = var.secret_rotation_interval

    }
  }

  dynamic "api_server_access_profile" {
    for_each = var.api_server_authorized_ip_ranges != null || var.api_server_subnet_id != null ? ["api_server_access_profile"] : []

    content {
      authorized_ip_ranges = var.api_server_authorized_ip_ranges
      subnet_id            = var.api_server_subnet_id
    }
  }


  dynamic "auto_scaler_profile" {
    for_each = var.auto_scaler_profile_enabled ? ["default_auto_scaler_profile"] : []

    content {
      balance_similar_node_groups      = var.auto_scaler_profile_balance_similar_node_groups
      empty_bulk_delete_max            = var.auto_scaler_profile_empty_bulk_delete_max
      expander                         = var.auto_scaler_profile_expander
      max_graceful_termination_sec     = var.auto_scaler_profile_max_graceful_termination_sec
      max_node_provisioning_time       = var.auto_scaler_profile_max_node_provisioning_time
      max_unready_nodes                = var.auto_scaler_profile_max_unready_nodes
      max_unready_percentage           = var.auto_scaler_profile_max_unready_percentage
      new_pod_scale_up_delay           = var.auto_scaler_profile_new_pod_scale_up_delay
      scale_down_delay_after_add       = var.auto_scaler_profile_scale_down_delay_after_add
      scale_down_delay_after_delete    = local.auto_scaler_profile_scale_down_delay_after_delete
      scale_down_delay_after_failure   = var.auto_scaler_profile_scale_down_delay_after_failure
      scale_down_unneeded              = var.auto_scaler_profile_scale_down_unneeded
      scale_down_unready               = var.auto_scaler_profile_scale_down_unready
      scale_down_utilization_threshold = var.auto_scaler_profile_scale_down_utilization_threshold
      scan_interval                    = var.auto_scaler_profile_scan_interval
      skip_nodes_with_local_storage    = var.auto_scaler_profile_skip_nodes_with_local_storage
      skip_nodes_with_system_pods      = var.auto_scaler_profile_skip_nodes_with_system_pods
    }
  }


  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.role_based_access_control_enabled && var.rbac_aad && var.rbac_aad_managed ? ["rbac"] : []

    content {
      admin_group_object_ids = var.rbac_aad_admin_group_object_ids
      azure_rbac_enabled     = var.rbac_aad_azure_rbac_enabled
      managed                = true
      tenant_id              = var.rbac_aad_tenant_id
    }
  }

  dynamic "azure_active_directory_role_based_access_control" {
    for_each = var.role_based_access_control_enabled && var.rbac_aad && !var.rbac_aad_managed ? ["rbac"] : []

    content {
      client_app_id     = var.rbac_aad_client_app_id
      managed           = false
      server_app_id     = var.rbac_aad_server_app_id
      server_app_secret = var.rbac_aad_server_app_secret
      tenant_id         = var.rbac_aad_tenant_id
    }
  }


  dynamic "identity" {
    for_each = var.client_id == "" || var.client_secret == "" ? ["identity"] : []

    content {
      type         = var.identity_type
      identity_ids = var.identity_ids
    }
  }



  dynamic "linux_profile" {
    for_each = var.admin_username == null ? [] : ["linux_profile"]

    content {
      admin_username = var.admin_username

      ssh_key {
        key_data = replace(coalesce(var.public_ssh_key, tls_private_key.ssh[0].public_key_openssh), "\n", "")
      }
    }
  }



  dynamic "maintenance_window" {
    for_each = var.maintenance_window != null ? ["maintenance_window"] : []

    content {
      dynamic "allowed" {
        for_each = var.maintenance_window.allowed

        content {
          day   = allowed.value.day
          hours = allowed.value.hours
        }
      }
      dynamic "not_allowed" {
        for_each = var.maintenance_window.not_allowed

        content {
          end   = not_allowed.value.end
          start = not_allowed.value.start
        }
      }
    }
  }


  dynamic "microsoft_defender" {
    for_each = var.microsoft_defender_enabled ? ["microsoft_defender"] : []

    content {
      log_analytics_workspace_id = local.log_analytics_workspace.id
    }
  }


  dynamic "monitor_metrics" {
    for_each = var.monitor_metrics != null ? ["monitor_metrics"] : []

    content {
      annotations_allowed = var.monitor_metrics.annotations_allowed
      labels_allowed      = var.monitor_metrics.labels_allowed
    }
  }

  network_profile {
    network_plugin      = var.network_plugin
    dns_service_ip      = var.net_profile_dns_service_ip
    ebpf_data_plane     = var.ebpf_data_plane
    load_balancer_sku   = var.load_balancer_sku
    network_plugin_mode = var.network_plugin_mode
    network_policy      = var.network_policy
    outbound_type       = var.net_profile_outbound_type
    pod_cidr            = var.net_profile_pod_cidr
    service_cidr        = var.net_profile_service_cidr

    dynamic "load_balancer_profile" {
      for_each = var.load_balancer_profile_enabled && var.load_balancer_sku == "standard" ? ["load_balancer_profile"] : []

      content {
        idle_timeout_in_minutes     = var.load_balancer_profile_idle_timeout_in_minutes
        managed_outbound_ip_count   = var.load_balancer_profile_managed_outbound_ip_count
        managed_outbound_ipv6_count = var.load_balancer_profile_managed_outbound_ipv6_count
        outbound_ip_address_ids     = var.load_balancer_profile_outbound_ip_address_ids
        outbound_ip_prefix_ids      = var.load_balancer_profile_outbound_ip_prefix_ids
        outbound_ports_allocated    = var.load_balancer_profile_outbound_ports_allocated
      }
    }
  }

  dynamic "default_node_pool" {
    for_each = var.enable_auto_scaling == true ? [] : ["default_node_pool_manually_scaled"]
    content {

    }

  }

  lifecycle {
    create_before_destroy = true
    ignore_changes        = [kubernetes_version, default_node_pool[0].node_count]
  }

}


resource "azurerm_role_assignment" "acr" {
  for_each = var.attached_acr_id_map
  principal_id                     = azurerm_kubernetes_cluster.aks_cluster.kubelet_identity[0].object_id
  scope                            = each.value
  role_definition_name             = "AcrPull"
  skip_service_principal_aad_check = true
}
