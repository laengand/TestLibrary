using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using IA.Common.StandardCommunication;
using System.IO;
using System.Threading;
using IA.Common.StandardCommunication.Tools;

namespace TestLibrary
{
  public delegate void CmdCallback(ushort id, Parameters parameters, Parameters replyParameters, Stream bulk, int bulkLength);
  public class CmdEntry
  {
    private ushort id;
    private Parameters parameters;
    private Stream bulk;
    private int bulkLength;
    private CmdCallback callback;
    private CommandStatus cmdType;

    public ushort Id
    {
      get { return id; }
    }
    public Parameters Parameters
    {
      set { parameters = value; }
      get { return parameters; }
    }
    public Stream Bulk
    {
      get { return bulk; }
    }
    public int BulkLength
    {
      get { return bulkLength; }
    }
    public CmdCallback Callback
    {
      get { return callback; }
    }
    public CommandStatus CommandType
    {
      get { return cmdType; }
    }
    public CmdEntry(ushort id, Parameters parameters, Stream bulk, int bulkLength, CmdCallback callback)
    {
      this.id = id;

      if ((id & Constants.SetDataBit) != 0)
        cmdType = CommandStatus.BulkSent;
      else if ((id & Constants.GetDataBit) != 0)
        cmdType = CommandStatus.BulkReceived;
      else
        cmdType = CommandStatus.NoBulk;

      this.parameters = parameters;
      this.bulk = bulk;
      this.bulkLength = bulkLength;
      this.callback = callback;
    }
  }
  
}
