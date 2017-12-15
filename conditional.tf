# Assets generated only when certain options are chosen

resource "template_dir" "flannel-manifests-shared" {
  count           = "${var.networking == "flannel" || var.networking == "canal" ? 1 : 0}"
  source_dir      = "${path.module}/resources/flannel-shared"
  destination_dir = "${var.asset_dir}/manifests-flannel-shared"

  vars {
    flannel_image     = "${var.container_images["flannel"]}"
    flannel_cni_image = "${var.container_images["flannel_cni"]}"
    flannel_backend   = "${var.flannel_backend}"
    flannel_iface     = "${var.flannel_iface}"

    pod_cidr = "${var.pod_cidr}"
  }
}

resource "template_dir" "flannel-manifests" {
  count           = "${var.networking == "flannel" ? 1 : 0}"
  source_dir      = "${path.module}/resources/flannel"
  destination_dir = "${var.asset_dir}/manifests-networking"

  vars {
    flannel_image     = "${var.container_images["flannel"]}"
    flannel_cni_image = "${var.container_images["flannel_cni"]}"

    pod_cidr = "${var.pod_cidr}"
  }
}

resource "template_dir" "calico-manifests-shared" {
  count           = "${var.networking == "calico" || var.networking == "canal" ? 1 : 0}"
  source_dir      = "${path.module}/resources/calico-shared"
  destination_dir = "${var.asset_dir}/manifests-calico-shared"

  vars {
    calico_image     = "${var.container_images["calico"]}"
    calico_cni_image = "${var.container_images["calico_cni"]}"

    network_mtu = "${var.network_mtu}"
    pod_cidr    = "${var.pod_cidr}"
  }
}

resource "template_dir" "calico-manifests" {
  count           = "${var.networking == "calico" ? 1 : 0}"
  source_dir      = "${path.module}/resources/calico"
  destination_dir = "${var.asset_dir}/manifests-networking"

  vars {
    calico_image     = "${var.container_images["calico"]}"
    calico_cni_image = "${var.container_images["calico_cni"]}"

    network_mtu = "${var.network_mtu}"
    pod_cidr    = "${var.pod_cidr}"
  }
}

resource "template_dir" "canal-manifests" {
  count           = "${var.networking == "canal" ? 1 : 0}"
  source_dir      = "${path.module}/resources/canal"
  destination_dir = "${var.asset_dir}/manifests-networking"

  vars {
    calico_image     = "${var.container_images["calico"]}"
    calico_cni_image = "${var.container_images["calico_cni"]}"

    flannel_image     = "${var.container_images["flannel"]}"
    flannel_cni_image = "${var.container_images["flannel_cni"]}"

    network_mtu = "${var.network_mtu}"
    pod_cidr    = "${var.pod_cidr}"
  }
}
