Description
-----------

Installs and configures ElasticSearch on AWS OpsWorks.

Requirements
------------

Tested against Amazon Linux 2015.09 with Chef 11.10, but may be compatible with similar versions.

Usage
-----

To use these cookbooks with OpsWorks, include this repo as a submodule into your own cookbooks as a recipe.
In opsworks, create a new layer with a short name of `elasticsearch`. Add your repository as the Custom Chef Recipes repository.
Next configure OpsWorks to run these recipes:

* Setup: `elasticsearch::install, elasticsearch::packages`
* Configure: `elasticsearch`

Add an EBS volume with a mount point of `/data`.

You'll also need to set up a security group for these servers that allows port 9200 from the appropriate sources.

Then just boot up instances for the elasticsearch layer. As new servers are added, they will automatically cluster with each other.

Basic Auth
----------
HTTP basic auth is supported by installing this plugin [elasticsearch-http-basic](https://github.com/Asquera/elasticsearch-http-basic).
All that's needed to make this work on OpsWorks is to add the appropriate configuration to the OpsWorks Stack Custom Chef JSON.

```json
{
  "elasticsearch": {
    "basic_auth": {
      "user": "username",
      "password": "password"
    }
  }
}
```

Testing
-------
Testing is done with http://www.foodcritic.io/ and http://kitchen.ci/

To run the test suite, execute rake: `bundle exec rake`.

## Testing Monit Integration
By default the Monit HTTP interface is disabled which is required for CLI tools like `monit status`.  If you want to 
enable it for development and testing add the folling lines to `/etc/monit.conf` and run `sudo service monit restart`.
```
set httpd port 2812 and use the address localhost
  allow localhost
```
