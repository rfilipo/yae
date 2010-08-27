/***************************************************************
 * Name:      yaeApp.cpp
 * Purpose:   Code for Application Class
 * Author:    monsenhor (ricardo.filipo@kobkob.com.br)
 * Created:   2010-08-15
 * Copyright: monsenhor (www.kobkob.com.br)
 * License:
 **************************************************************/

#ifdef WX_PRECOMP
#include "wx_pch.h"
#endif

#ifdef __BORLANDC__
#pragma hdrstop
#endif //__BORLANDC__

#include "yaeApp.h"
#include "yaeMain.h"

IMPLEMENT_APP(yaeApp);

bool yaeApp::OnInit()
{
    yaeFrame* frame = new yaeFrame(0L);
    
    frame->Show();
    
    return true;
}
