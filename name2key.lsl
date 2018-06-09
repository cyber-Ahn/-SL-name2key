string NAME;integer wert_send;
integer wert_input;
key gChannel;
string data_send;
string data_input;
string data_out;
send()
{
    data_send = NAME;
    wert_send = 1;
    data_out = "nval=" + data_send + "&ival="+ (string)wert_send+ "&cval="+(string)gChannel;
    llHTTPRequest("http://cyber.caworks-sl.de/name2key/n2k.php",[HTTP_METHOD, "POST",HTTP_MIMETYPE, "application/x-www-form-urlencoded"],data_out);

}
default
{
    state_entry()
    {
        llListen(101, "", "", "");
        llOpenRemoteDataChannel();
    }
    link_message(integer sender, integer num, string msg, key id)
    {
        if(num == 101)
        {
            NAME = msg;
            send();
        }
    }
    listen(integer c, string n, key id, string message)
    {
        NAME = message;
        send();
    }
    remote_data(integer type, key channel, key message_id, string sender, integer ival, string sval)
    {
        if (type == REMOTE_DATA_CHANNEL)
        {
            gChannel = channel;
        }
        if (type == REMOTE_DATA_REQUEST)
        {
            wert_input = ival;
            data_input = sval;
            if(wert_input == 2)
            {
                llSay(0,NAME+": "+data_input);
            }
        }
    }
    on_rez (integer parms)
    {
        llResetScript();
    }
}