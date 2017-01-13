class netdata::webserver inherits netdata {

  if $netdata::webserver_manage {
    require $netdata::webserver_class

    $all_nodes_query = 'nodes [certname] {}'
    $all_nodes = puppetdb_query($all_nodes_query).each |$value| { $value["certname"] }

    $echo_nodes = join($all_nodes, ', ')
    notify {'All nodes':
      message => "Your nodes are ${echo_nodes}",
    }
  }
}