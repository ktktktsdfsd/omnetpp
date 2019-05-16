

#include <stdio.h>
#include <string.h>
#include <omnetpp.h>

using namespace omnetpp;
    class Node:public cSimpleModule
    {
    private:
        int no_sent;
        int no_rcvd;
        int bc=0;
      //  double time_interval;
    protected:
        virtual void initialize();
        virtual void handleMessage(cMessage *msg);
        virtual void finish();
    };
    Define_Module(Node);

    void Node::initialize()
    {
        no_sent= 0;
        no_rcvd= 0;
        //time_interval = par(time_interval);

                char msgname[64];
                sprintf(msgname, "no_sent-%d", getIndex());
                cMessage *msg = new cMessage(msgname);
                scheduleAt(0.0, msg);

    }

    void Node::handleMessage(cMessage *msg)
    {
        char msg0[64];
        sprintf(msg0, "CLIENTHELLO");
        cMessage *msg2 = new cMessage(msg0);

        char msg1[256];
        sprintf(msg1, "HESAP_VERI", getIndex());
        cMessage *msg3 = new cMessage(msg1);

        switch(bc){
        case 0:
            send(msg2,"out");
            break;
        case 1:
            send(msg3,"out");
            break;
        case 2:
            delete(msg);
       }

        bc = (bc+1)%3;

            no_sent++;
            //scheduleAt(simTime()+time_interval,out_msg);


    }

    void Node::finish()
    {
        recordScalar("Number Of received messages",no_rcvd);
        recordScalar("Number Of sent messages",no_sent);
    }


