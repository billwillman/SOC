#define _USE_FAIRY_GUI

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

#if _USE_FAIRY_GUI

[XLua.LuaCallCSharp]
public class FairyGUIResLoaderAsyncMono: BaseResLoaderAsyncMono {

}

#endif