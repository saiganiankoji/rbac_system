## RbacSystem

The `rbac_system` gem provides a robust Role-Based Access Control (RBAC) implementation, enabling you to efficiently manage admin roles and permissions within your application. With this gem, you can easily define and enforce authorization rules for various resources and actions.

## Overview

This gem allows you to define three primary entities:

1. **Admin**: Represents your admin users and their basic details.
2. **Role**: Defines roles with specific permissions.

   - **Name**: The name of the role (e.g., `Editor`, `Viewer`).
   - **Permissions**: A hash mapping resources to their respective actions. For example:

     ```
     {
       Upload: { manage: true, create: true },
       Download: { manage: true, read: true },
       Area: { manage: true, create: true, update: true, read: true },
       City: { manage: true, create: true, update: true, read: true },
       AccountLedger: { manage: true, read: true },
       CouponDiscount: { manage: true, read: true, create: true, update: true }
     }
     ```

   In this example, `Upload` and `Download` are custom resource names, while `Area`, `City`, etc., correspond to database models.

3. **AdminRole**: A junction table that connects `Admin` and `Role` entities, allowing you to assign roles to admins.

## Installation

To install the gem, add it to your application's Gemfile:

```bash
bundle add rbac_system
```

If bundler is not being used to manage dependencies, install the gem by executing:

```bash
gem install rbac_system
```

## Usage

To use the rbac_system gem, you need to check authorization based on the current admin, the action being performed, and the resource name. Here are some usage scenarios:

before_action :check_authorization

## Case 1: Model Exists in Database

For a standard model, you can implement authorization as follows:

```
def check_authorization
    action_map = {
        'create_area' => 'create',
        'area_listing' => 'read',
        'update_area' => 'update'
    }
    action = action_map[action_name]
    resource = controller_name.classify

    authorized = RbacSystem::Authorization.new(current_admin, resource, action).authorized?

    # If not authorized, render a forbidden error
    unless authorized
        render json: { status: 'failure', message: 'Forbidden', errors: ['You are not authorized to perform this action'] }, status: :forbidden
    end
end
```

## Case 2: Multiple Models in a Single Controller

If your controller manages multiple models, use the following approach:

```
def  check_authorization
    action_map = {
    'add_update_cart' => { action: 'create', resource: 'Cart' },
    'cart_checkout' => { action: 'create', resource: 'Cart' },
    'validate_discount' => { action: 'create', resource: 'Cart' },
    'get_cart_summary' => { action: 'read', resource: 'Cart' },
    'place_order' => { action: 'create', resource: 'Order' },
    'order_deliver' => { action: 'read', resource: 'Order' },
    'clear_cart' => { action: 'put', resource: 'Cart' },
    'get_orders' => { action: 'read', resource: 'Order' },
    'get_carts' => { action: 'read', resource: 'Cart' },
    'verify_unicommerce_order_status' => { action: 'update', resource: 'Order' },
    'unicommerce_snapshot' => { action: 'read', resource: 'ProductSku' },
    'cancel_order' => { action: 'create', resource: 'Order' },
    'get_unicommerce_order_status' => { action: 'read', resource: 'Order' }
    }

    action_info = action_map[action_name]
    action = action_info[:action]
    resource = action_info[:resource]

    authorized = RbacSystem::Authorization.new(admin, resource, action).authorized?

    unless authorized
    render json: { status: 'failure', message: 'Forbidden', errors: ['You are not authorized to perform this action'] }, status: :forbidden
    end

end
```

## Case 3: Custom Resource Names

If you need to define custom resource names without a corresponding model, you can do this:

```
def check_authorization
    action_map = {
    'bulk_sku_upload' => 'create',
    'bulk_option_values_upload' => 'create',
    'bulk_option_value_sku_mappings_upload' => 'create',
    'bulk_product_medias_upload' => 'create'
    }

    action = action_map[action_name]
    resource = 'Upload'

    authorized = RbacSystem::Authorization.new(admin, resource, action).authorized?

    unless authorized
    render json: { status: 'failure', message: 'Forbidden', errors: ['You are not authorized to perform this action'] }, status: :forbidden
    end
end
```

## Development

After checking out the repository, run bin/setup to install dependencies. You can run tests with:
rake spec

For an interactive prompt to experiment, run:
bin/console

To install the gem onto your local machine, execute:

bundle exec rake install

To release a new version, update the version number in version.rb, and then run:
bundle exec rake release

This will create a Git tag for the version, push Git commits and the created tag, and push the .gem file to RubyGems.org.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/saiganiankoji/rbac_system. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the Code of Conduct.

## License

The gem is available as open source under the terms of the MIT License.

## Code of Conduct

### Key Improvements:

1. **Clarity and Structure**: The README is structured into clear sections with headings, making it easy to navigate.
2. **Comprehensive Usage Instructions**: Each usage case is explained with code examples, making it easy for users to understand how to implement the gem.
3. **Development and Contributing Guidelines**: Clear instructions for development, contributing, and licensing provide users with the necessary information to participate in the project.

Feel free to customize any sections as needed, especially the GitHub links and any specific details regarding your implementation!

```

```
