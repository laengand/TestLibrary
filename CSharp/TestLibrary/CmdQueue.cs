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
    Exception latestException = null;
    AutoResetEvent newQueueData = new AutoResetEvent(false);
    ConcurrentQueue<CmdEntry> queue;
    bool exitThread = false;
    IStandardCommunication communication;
    public Exception LatestException
    {
      get { return latestException; }
    }
    public void Clear()
    {
      while (!queue.IsEmpty)
      {
        CmdEntry entry;
        queue.TryDequeue(out entry);
      }
    }
    public CmdQueue(IStandardCommunication communication)
    {
      this.communication = communication;
      queue = new ConcurrentQueue<CmdEntry>();
    }
    public void Enqueue(CmdEntry entry)
    {
      if (thread == null || !thread.IsAlive)
      {
        thread = new Thread(DequeueThread);
        thread.Start();
      }

      queue.Enqueue(entry);
      newQueueData.Set();
    }
    void DequeueThread()
    {
      while (true)
      {
        if (exitThread || !communication.Connected)
        {
          Clear();
          return;
        }
        newQueueData.WaitOne(500, false);
        while (!queue.IsEmpty && !exitThread)
        {
          Dequeue();
        }
      }
    }
    bool Dequeue()
    {
      if (!communication.Connected)
      {
        Clear();
        exitThread = true;
        return false;
      }
      CmdEntry entry;
      bool rtn = queue.TryDequeue(out entry);
      latestException = null;
      if (rtn && communication.Connected)
      {
        Parameters replyParameters = entry.Parameters;
        try
        {
          if (entry.CommandType == CommandStatus.BulkSent)
            communication.SendCommand(entry.Id, ref replyParameters, entry.Bulk, entry.BulkLength);
          else if (entry.CommandType == CommandStatus.BulkReceived)
            communication.SendCommand(entry.Id, ref replyParameters, entry.Bulk);
          else
            communication.SendCommand(entry.Id, ref replyParameters);
          entry.Callback(entry.Id, entry.Parameters, replyParameters, entry.Bulk, entry.BulkLength, entry.IsBlocking);
        }
        catch (Exception ex)
        {
          if (ex.GetType() == typeof(CommandFailedException))
          {
            replyParameters.Write(((CommandFailedException)ex).Command);
            replyParameters.Write(((CommandFailedException)ex).ErrorCode);
          }
          latestException = ex;
          entry.Callback(entry.Id, entry.Parameters, replyParameters, entry.Bulk, entry.BulkLength, entry.IsBlocking);
        }

      }
      return rtn;
    }

    public void Dispose()
    {
      exitThread = true;
    }
  }
}
