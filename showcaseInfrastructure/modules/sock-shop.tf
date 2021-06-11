resource "kubernetes_namespace" "sock-shop" {
  metadata {
    name = "sock-shop"
  }
}

resource "null_resource" "debuggerv2" {
  provisioner "local-exec" {
    command = "ls -la; pwd"
  }
}


resource "helm_release" "sock-shop-helm-chart" {
  depends_on = [kubernetes_namespace.sock-shop]
  name       = "sock-shop-helm-chart"
  chart      = "sock-shop-helm/helm-chart"
  namespace  = "sock-shop" 
  timeout    = "500"

  set {
    name  = "azure.app_insights"
    value = azurerm_application_insights.app_insights.instrumentation_key
  }

}