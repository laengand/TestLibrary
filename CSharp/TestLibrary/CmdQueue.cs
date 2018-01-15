using System;
using System.Collections.Concurrent;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using IA.Common.StandardCommunication;
using IA.Common.StandardCommunication.Tools;

namespace TestLibrary
{
  public class CmdQueue : IDisposable
  {
    Thread thread;
    AutoResetEvent newQueueData = new AutoResetEvent(false);
    ConcurrentQueue<CmdEntry> queue;
    bool exitThread = false;
    IStandardCommunication communication;
    public CmdQueue(IStandardCommunication communication)
    {
      this.communication = communication;
      queue = new ConcurrentQueue<CmdEntry>();
      thread = new Thread(DequeueThread);
      thread.Start();
    }
    public void Enqueue(CmdEntry entry)
    {
      queue.Enqueue(entry);
      newQueueData.Set();
    }
    void DequeueThread()
    {
      while(true)
      {
        if (!exitThread)
          return;

        newQueueData.WaitOne(500, false);
        while (!queue.IsEmpty)
        {
          Dequeue();
        }
      }
    }
    bool Dequeue()
    {
      CmdEntry entry;
      bool rtn = queue.TryDequeue(out entry);
      if (rtn)
      {
        Parameters replyParameters = entry.Parameters;
        if (entry.CommandType == CommandStatus.BulkSent)
          communication.SendCommand(entry.Id, ref replyParameters, entry.Bulk, entry.BulkLength);
        else if (entry.CommandType == CommandStatus.BulkReceived)
          communication.SendCommand(entry.Id, ref replyParameters, entry.Bulk);
        else
          communication.SendCommand(entry.Id, ref replyParameters);

        entry.Callback(entry.Id, entry.Parameters, replyParameters, entry.Bulk, entry.BulkLength);
      }
      return rtn;
    }

    public void Dispose()
    {
      exitThread = true;
    }
  }
}
