import 'dart:io';

class Product {
  int id;
  String name;
  double price;
  int quantity;

  Product(this.id, this.name, this.price, this.quantity);

  @override
  String toString() {
    return 'ID: $id, Name: $name, Price: \$$price, Quantity: $quantity';
  }
}

void main() {
  Map<int, Product> inventory = {};

  while (true) {
    print('\nInventory Management System');
    print('1. Add Product');
    print('2. Update Product');
    print('3. Remove Product');
    print('4. List Products');
    print('5. Calculate Total Value');
    print('6. Exit');
    stdout.write('Enter your choice: ');
    String choice = stdin.readLineSync() ?? '';

    switch (choice) {
      case '1':
        addProduct(inventory);
        break;
      case '2':
        updateProduct(inventory);
        break;
      case '3':
        removeProduct(inventory);
        break;
      case '4':
        listProducts(inventory);
        break;
      case '5':
        calculateTotalValue(inventory);
        break;
      case '6':
        exit(0);
        break;
      default:
        print('Invalid choice. Please try again.');
        break;
    }
  }
}

void addProduct(Map<int, Product> inventory) {
  print('\nAdd Product');
  stdout.write('Enter Product ID: ');
  int id = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  if (id <= 0) {
    print('Invalid ID. Please enter a positive integer.');
    return;
  }

  if (inventory.containsKey(id)) {
    print('Product with ID $id already exists.');
    return;
  }

  stdout.write('Enter Product Name: ');
  String name = stdin.readLineSync() ?? '';

  stdout.write('Enter Product Price (\$): ');
  double price = double.tryParse(stdin.readLineSync() ?? '') ?? 0.0;

  if (price <= 0) {
    print('Invalid price. Please enter a positive number.');
    return;
  }

  stdout.write('Enter Product Quantity: ');
  int quantity = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  if (quantity <= 0) {
    print('Invalid quantity. Please enter a positive integer.');
    return;
  }

  Product product = Product(id, name, price, quantity);
  inventory[id] = product;
  print('Product added successfully.');
}

void updateProduct(Map<int, Product> inventory) {
  print('\nUpdate Product');
  stdout.write('Enter Product ID to update: ');
  int id = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  if (id <= 0 || !inventory.containsKey(id)) {
    print('Product with ID $id does not exist.');
    return;
  }

  stdout.write('Enter new Product Name (press Enter to skip): ');
  String? name = stdin.readLineSync();

  stdout.write('Enter new Product Price (\$) (press Enter to skip): ');
  String? priceInput = stdin.readLineSync();
  double price = priceInput == null || priceInput.isEmpty
      ? inventory[id]!.price
      : double.tryParse(priceInput) ?? inventory[id]!.price;

  if (price <= 0) {
    print('Invalid price. Please enter a positive number.');
    return;
  }

  stdout.write('Enter new Product Quantity (press Enter to skip): ');
  String? quantityInput = stdin.readLineSync();
  int quantity = quantityInput == null || quantityInput.isEmpty
      ? inventory[id]!.quantity
      : int.tryParse(quantityInput) ?? inventory[id]!.quantity;

  if (quantity <= 0) {
    print('Invalid quantity. Please enter a positive integer.');
    return;
  }

  Product updatedProduct = Product(id, name ?? inventory[id]!.name, price, quantity);
  inventory[id] = updatedProduct;
  print('Product updated successfully.');
}

void removeProduct(Map<int, Product> inventory) {
  print('\nRemove Product');
  stdout.write('Enter Product ID to remove: ');
  int id = int.tryParse(stdin.readLineSync() ?? '') ?? 0;

  if (id <= 0 || !inventory.containsKey(id)) {
    print('Product with ID $id does not exist.');
    return;
  }

  inventory.remove(id);
  print('Product removed successfully.');
}

void listProducts(Map<int, Product> inventory) {
  print('\nList of Products');
  if (inventory.isEmpty) {
    print('No products in inventory.');
  } else {
    inventory.forEach((id, product) {
      print(product);
    });
  }
}

void calculateTotalValue(Map<int, Product> inventory) {
  print('\nCalculate Total Value');
  double totalValue = 0.0;

  inventory.forEach((id, product) {
    totalValue += product.price * product.quantity;
  });

  print('Total Value of Inventory: \$$totalValue');
}