//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

package src;

//
// TODO auto-generated type
//
network Net2
{
    parameters:
        int n_nodes;

        @display("bgb=149,95");
    types:
        channel Channel extends ned.DelayChannel {
            delay = 100ms;
        }
         channel Channel1 extends ned.DelayChannel {
            delay = 120ms;
        }
        channel Channel2 extends ned.DelayChannel {
            delay = 140ms;
        }

    submodules:
        hub: Hub {
            @display("i=device/server");
        }
        node[n_nodes]: Node {

            @display("i=device/pc");
        }
    connections:
        for i=2..n_nodes-1 {
            node[i].out --> Channel --> hub.in++;
            hub.out++ --> Channel --> node[i].in;
        }
   
        node[0].out --> Channel1 --> hub.in++;
        hub.out++ --> Channel1 --> node[0].in;
        node[1].out --> Channel2 --> hub.in++;
        hub.out++ --> Channel2 --> node[1].in;
              
}
