/***************************************************************
 * Name:      yaeMain.cpp
 * Purpose:   Code for YAE Main Frame
 * Author:    monsenhor (ricardo.filipo@kobkob.com.br)
 * Created:   2010-08-15
 * Copyright: monsenhor (www.kobkob.com.br)
 * License:   LGPL
 **************************************************************/

#define WXINTL_NO_GETTEXT_MACRO 1

/* some static globals */
#define VERSION        "0.01_01"
#define my_name        "YAE"


#ifdef WX_PRECOMP
#include "wx_pch.h"
#endif

#ifdef __BORLANDC__
#pragma hdrstop
#endif //__BORLANDC__

#include <string>
#include "yaeMain.h"

/* glue to share things with perl */
extern "C" {
    #include <EXTERN.h>               /* from the Perl distribution     */
    #include <perl.h>                 /* from the Perl distribution     */
    #include "ppport.h"

    EXTERN_C void xs_init (pTHX);
    EXTERN_C void boot_DynaLoader (pTHX_ CV* cv);

    EXTERN_C void xs_init(pTHX)
    {
      	char *file = __FILE__;
      	dXSUB_SYS;

      	/* DynaLoader is a special case */
      	newXS("DynaLoader::boot_DynaLoader", boot_DynaLoader, file);
    }
}


static PerlInterpreter *my_perl;


//helper functions
enum wxbuildinfoformat {
    short_f, long_f };

wxString wxbuildinfo(wxbuildinfoformat format)
{
    wxString wxbuild(wxVERSION_STRING);

    if (format == long_f )
    {
#if defined(__WXMSW__)
        wxbuild << _T("-Windows");
#elif defined(__WXMAC__)
        wxbuild << _T("-Mac");
#elif defined(__UNIX__)
        wxbuild << _T("-Linux");
#endif

#if wxUSE_UNICODE
        wxbuild << _T("-Unicode build");
#else
        wxbuild << _T("-ANSI build");
#endif // wxUSE_UNICODE
    }

    return wxbuild;
}


yaeFrame::yaeFrame(wxFrame *frame)
    : GUIFrame(frame)
{
#if wxUSE_STATUSBAR
    statusBar->SetStatusText(_T("YAE ERP 0.01_01 -  Debug!"), 0);
    statusBar->SetStatusText(wxbuildinfo(short_f), 1);
#endif

    /* perl hooks */

    char *myargs[] = { NULL };
    char *embed[] = { "", "-e", "\0" } ;

    my_perl = perl_alloc();
    perl_construct(my_perl);

    perl_parse(my_perl, xs_init, 3, embed, NULL);
    PL_exit_flags |= PERL_EXIT_DESTRUCT_END;
    perl_run(my_perl);

    /* perl hooks inited */

}

yaeFrame::~yaeFrame()
{
    /* clean perl hooks */
    perl_destruct(my_perl);
    perl_free(my_perl);

}


void yaeFrame::OnClose(wxCloseEvent &event)
{
    Destroy();
}

void yaeFrame::OnQuit(wxCommandEvent &event)
{
    Destroy();
}

void yaeFrame::OnAbout(wxCommandEvent &event)
{

    /* evaluate perl code */
    std::string code = "                          \
    $testevar = 98;                               \
    $testebar = 97;                               \
    ";
    eval_pv( &code[0], TRUE);

    /* get perl data */
    int teste = SvIV(get_sv("testevar", 0));
    printf("huuu = %d\n",teste);

    /* evaluate function at perl script */
    char *myargs[] = { NULL };
    eval_pv("require('bin/testeWx.pl');", TRUE);
    call_argv("showhu", G_DISCARD | G_NOARGS, myargs);

}

