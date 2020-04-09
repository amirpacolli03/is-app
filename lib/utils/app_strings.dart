class AppStrings {
  static const Map<String, String> appStrings = {
    "app_name": "Internetstores App",
    "create_product": "Create Product",
    "update_product": "Update Product",
    "uploade_image_validation_error": "Upload an image to conntinue",
    "product_name": "Product Name",
    "product_description": "Product Description",
    "product_price_range": "Product Price Range",
    "product_frame_size": "Product Frame Size",
    "product_category": "Product Category",
    "product_location": "Product Location",
    "save": "Save",
    "add_image": "Add Image",
    "camera": "Camera",
    "gallery": "Gallery",
    "update": "Update",
    "delete": "Delete",
    "price": "Price",
    "frame_size": "Frame Size",
    "category": "Category",
    "location": "Location",
    "error_message": "Something went wrong!"
  };

  static String translateKeys(String key) {
    return appStrings[key] ?? key;
  }
}
