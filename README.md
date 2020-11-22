# foodpanda Product Listing

In this project, we are going to build a simple product listing page based on a dummy JSON

## Test Brief

1. Rendering the grid view for listing the products based on the JSON ( products.json file in the project root ) showing the price/product name/image tile and add to cart/remove from cart button
2. Validating add to cart regarding two fields in JSON file associated with each product:

    a. User should not be able to add more than stock_amount

    b. User should not be able to add more than max_per_order

    c. User should not see the product with stock_amount equal to zero
    
    d. Stock_amout and max_per_order equal to -1 indicates there is no 
       limitation for adding the product
       
3. Showing the total quantity of product and total price

## UI guideline
![UI](./ui.png?raw=true)

## Technical Expectations

### Architecture

1. Following MVC architecture and concepts is a MUST
2. Rather than MVC, following VIPER architecture, is recommended as extra credit

### Testing

1. You should be able to write testable business logic. So covering the code on Unit Level in a MUST
2. Covering UI Test cases is recommenced as extra credit

### Source Control
1. Create a private repository and have regular commits.
2. Take care of readable commit message

### Limitation

1. Project should be compatible with XCode 11.0, iOS 13.5

2. Project should be on swift and based on storyboard

3. There is no limitation on using any third-party libraries for UI Layout/ Styling/ Themes/ Testing/ Formatters

4. Using Any third-party libraries for the direct implementation of the functional requirements is not acceptable

5. Using iPhone 11 Pro Max is recommanded for simulator.
