/***************************************************************
 * Name:      yaeMain.h
 * Purpose:   Defines Application Frame
 * Author:    monsenhor (ricardo.filipo@kobkob.com.br)
 * Created:   2010-08-15
 * Copyright: monsenhor (www.kobkob.com.br)
 * License:
 **************************************************************/

#ifndef YAEMAIN_H
#define YAEMAIN_H



#include "yaeApp.h"


#include "GUIFrame.h"

class yaeFrame: public GUIFrame {
    public:
        yaeFrame(wxFrame *frame);
        ~yaeFrame();
    private:
        virtual void OnClose(wxCloseEvent& event);
        virtual void OnQuit(wxCommandEvent& event);
        virtual void OnAbout(wxCommandEvent& event);
};

#endif // YAEMAIN_H
