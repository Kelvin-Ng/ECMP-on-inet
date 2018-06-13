package ecmprouter.simulations;

import ecmprouter.ECMPRouter;

import inet.node.ethernet.*;
import inet.node.inet.*;
import inet.networklayer.configurator.ipv4.*;

@license(LGPL);

network Test1
{
    parameters:
        int numClients; // number of clients in the network
    submodules:
        configurator: IPv4NetworkConfigurator {
            @display("p=770,22");
        }
        server: StandardHost {
            @display("p=899,115");
        }
        router_path_1: ECMPRouter {
            @display("p=491,69");
        }
        switch_client: EtherSwitch {
            @display("p=156,114");
        }
        switch_server_path_1: EtherSwitch {
            @display("p=597,68");
        }
        client[numClients]: StandardHost {

            @display("p=37,115");
        }
        router_path_2: ECMPRouter {
            @display("p=491,165");
        }
        switch_server_path_2: EtherSwitch {
            @display("p=597,164");
        }
        router_client: ECMPRouter {
            @display("p=270,115");
        }
        switch_client_path_1: EtherSwitch {
            @display("p=375,68");
        }
        router_server: ECMPRouter {
            @display("p=715,115");
        }
        switch_server: EtherSwitch {
            @display("p=816,114");
        }
        switch_client_path_2: EtherSwitch {
            @display("p=375,164");
        }
    connections: // network level connections
        for i=0..numClients-1 {
            client[i].ethg++ <--> Eth1G <--> switch_client.ethg++; // ethernet
        }

        router_client.ethg++ <--> Eth1G <--> switch_client.ethg++;
        router_client.ethg++ <--> Eth1G <--> switch_client_path_1.ethg++;
        router_client.ethg++ <--> Eth1G <--> switch_client_path_2.ethg++;

        router_path_1.ethg++ <--> Eth1G <--> switch_client_path_1.ethg++;
        router_path_1.ethg++ <--> Eth1G <--> switch_server_path_1.ethg++;

        router_path_2.ethg++ <--> Eth1G <--> switch_client_path_2.ethg++;
        router_path_2.ethg++ <--> Eth1G <--> switch_server_path_2.ethg++;

        router_server.ethg++ <--> Eth1G <--> switch_server_path_1.ethg++;
        router_server.ethg++ <--> Eth1G <--> switch_server_path_2.ethg++;
        router_server.ethg++ <--> Eth1G <--> switch_server.ethg++;

        switch_server.ethg++ <--> Eth1G <--> server.ethg++;
}
