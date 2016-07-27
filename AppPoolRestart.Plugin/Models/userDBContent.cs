using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Data;
using System.Data.Entity;

namespace AppPoolRestart.Plugin.Models
{
    public class UserDBContext : DbContext
    {
        public UserDBContext() : base("umbracoDbDSN") { }
        public DbSet<User> Users { get; set; }
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);
            modelBuilder.Entity<User>().ToTable("umbracouser");
        }
    }
}