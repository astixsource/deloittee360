﻿using System;
using System.Threading.Tasks;
using Microsoft.Owin;
using Owin;

[assembly: OwinStartup(typeof(Startup))]

public class Startup
{
    public void Configuration(IAppBuilder app)
    {
        StartupAuth ss = new StartupAuth();
        ss.ConfigureAuth(app);
       
    }
}
