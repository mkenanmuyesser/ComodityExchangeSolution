//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace TicaretBorsasi_Project.Data
{
    using System;
    using System.Collections.Generic;
    
    public partial class LOG
    {
        public int LogKey { get; set; }
        public Nullable<System.DateTime> Tarih { get; set; }
        public string Message { get; set; }
        public string Source { get; set; }
        public string StackTrace { get; set; }
        public string ExceptionType { get; set; }
        public Nullable<System.Guid> UserId { get; set; }
        public string Url { get; set; }
    }
}
