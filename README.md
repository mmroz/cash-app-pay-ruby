# Cash App Pay Ruby Library

The Cash App Pay Ruby library provides convenient access to the Cash App Pay API from
applications written in the Ruby language. It includes a pre-defined set of
classes for API resources.

The library also provides other features. For example:

- Easy configuration path for fast setup and use.
- Helpers for pagination.
- Built-in mechanisms for the serialization of parameters according to the
  expectations of Cash App Pay API.

## Documentation

See the [Cash App Pay API docs](https://developers.cash.app/docs/api/welcome).

## Installation

You don't need this source code unless you want to modify the gem. If you just
want to use the package, just run:

```sh
gem install cash-app-pay
```

If you want to build the gem from source:

```sh
gem build cash_app_pay.gemspec
```

then install the gem locally:

```sh
gem install cash_app_pay-*.gem
```

Run Ruby and require the gem

```ruby
require 'cash_app_pay'
```

### Requirements

- Ruby 2.3+.

### Bundler

If you are installing via bundler, you should be sure to use the https rubygems
source in your Gemfile, as any gems fetched over http could potentially be
compromised in transit and alter the code of gems fetched securely over https:

```ruby
source 'https://rubygems.org'

gem 'rails'
gem 'cash-app-pay'
```

## Usage - Customer Request API

The libaray needs to be configured with your account's client_id. Set `CashAppPay.client_id` to its value:

```ruby
require 'cash-app-pay'
CashAppPay.client_id = 'CAS...'

# create a Customer Request
CashAppPay::CustomerRequest.create({ idempotency_key: 'xyz_123_...', channel: 'IN_APP', ... })

# retrieve single Customer Request
CashAppPay::CustomerRequest.retrieve('GRR_123456789')
```

## Usage - Network API

The libaray needs to be configured with your account's client_id as well as api_key, signature and region. Set `CashAppPay.client_id`, `CashAppPay.api_key`, `CashAppPay.signature` and `CashAppPay.region`:

```ruby
require 'cash-app-pay'
CashAppPay.client_id = 'CAS...'
CashAppPay.region = '...'
CashAppPay.signature = '...'
CashAppPay.api_key = 'KEY_...'

# create a Customer Request
CashAppPay::Merchant.create({ idempotency_key: 'xyz_123_...', name: 'My merchant', ... })

# retrieve single Customer Request
CashAppPay::Merchant.retrieve('MMI_123456789s')
```

### Per-request Configuration

For apps that need to use multiple keys during the lifetime of a process it's possible to set a
per-request:

```ruby
require 'cash-app-pay'

CashAppPay::CustomerRequest.create(
    { idempotency_key: 'xyz_123_...', channel: 'IN_APP', ... },
    { api_key: 'CAS...' }
)

```

## Development

Run all tests:

```sh
bundle exec rake test
```

Run a single test suite:

```sh
bundle exec rake test TEST=test/cash_app_pay/resources/payment_test.rb
```
