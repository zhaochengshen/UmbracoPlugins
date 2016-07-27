using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data.Entity;
using System.Data;

namespace PluginsUmbraco.App_Plugins.UserInfo.Models
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