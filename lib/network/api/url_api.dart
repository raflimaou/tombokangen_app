class BASEURL {
  static String ipAddress = "192.168.18.6";
  static String apiRegister =
      "http://$ipAddress/apitombokangen/register_api.php";
  static String apiLogin = "http://$ipAddress/apitombokangen/login_api.php";
  static String categoryWithProduct =
      "http://$ipAddress/apitombokangen/get_product_with_category.php";
  static String getProduct = "http://$ipAddress/apitombokangen/get_product.php";
  static String addToCart = "http://$ipAddress/apitombokangen/add_to_cart.php";
  static String getProductCart =
      "http://$ipAddress/apitombokangen/get_cart.php?userID=";
  static String updateQuantityProductCart =
      "http://$ipAddress/apitombokangen/update_quantity.php";
  static String totalPriceCart =
      "http://$ipAddress/apitombokangen/get_total_price.php?userID=";
  static String getTotalCart =
      "http://$ipAddress/apitombokangen/total_cart.php?userID=";
  static String checkout = "http://$ipAddress/apitombokangen/checkout.php";
  static String historyOrder =
      "http://$ipAddress/apitombokangen/get_history.php?id_user=";
  static String rekomendasiMenu =
      "http://$ipAddress/apitombokangen/rekomendasi_menu.php";
  static String tambahProduk = "http://$ipAddress/apitombokangen/add_data.php";
  static String editProduk = "http://$ipAddress/apitombokangen/edit_data.php";
  static String deleteProduk =
      "http://$ipAddress/apitombokangen/delete_data.php";
  static String getUser = "http://$ipAddress/apitombokangen/get_user.php";
  static String getUserById =
      "http://$ipAddress/apitombokangen/get_user_by_id.php?id_user=";
  static String editUser = "http://$ipAddress/apitombokangen/edit_user.php";
  static String getInvoice =
      "http://$ipAddress/apitombokangen/get_invoices.php";
  static String updateStatusInvoice =
      "http://$ipAddress/apitombokangen/update_status_invoice.php";
}
