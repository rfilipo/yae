///////////////////////////////////////////////////////////////////////////
// C++ code generated with wxFormBuilder (version Dec 29 2008)
// http://www.wxformbuilder.org/
//
// PLEASE DO "NOT" EDIT THIS FILE!
///////////////////////////////////////////////////////////////////////////

#ifndef __GUIFrame__
#define __GUIFrame__

#include <wx/string.h>
#include <wx/bitmap.h>
#include <wx/image.h>
#include <wx/icon.h>
#include <wx/menu.h>
#include <wx/gdicmn.h>
#include <wx/font.h>
#include <wx/colour.h>
#include <wx/settings.h>
#include <wx/statusbr.h>
#include <wx/calctrl.h>
#include <wx/html/htmlwin.h>
#include <wx/sizer.h>
#include <wx/panel.h>
#include <wx/treectrl.h>
#include <wx/scrolwin.h>
#include <wx/grid.h>
#include <wx/splitter.h>
#include <wx/textctrl.h>
#include <wx/notebook.h>
#include <wx/frame.h>

///////////////////////////////////////////////////////////////////////////

#define idMenuQuit 1000
#define idMenuAbout 1001

///////////////////////////////////////////////////////////////////////////////
/// Class GUIFrame
///////////////////////////////////////////////////////////////////////////////
class GUIFrame : public wxFrame 
{
	private:
	
	protected:
		wxMenuBar* mbar;
		wxMenu* fileMenu;
		wxMenu* helpMenu;
		wxStatusBar* statusBar;
		wxNotebook* m_notebook1;
		wxPanel* m_panel3;
		wxPanel* m_panel51;
		wxCalendarCtrl* m_calendar1;
		wxHtmlWindow* m_htmlWin1;
		wxHtmlWindow* m_htmlWin4;
		wxPanel* m_panel1;
		wxSplitterWindow* m_splitter4;
		wxScrolledWindow* m_scrolledWindow1;
		wxTreeCtrl* m_treeCtrl2;
		wxScrolledWindow* m_scrolledWindow2;
		wxGrid* m_grid1;
		wxPanel* m_panel2;
		wxTextCtrl* m_cliente_name;
		wxPanel* m_panel5;
		wxPanel* m_panel6;
		wxPanel* m_panel7;
		
		// Virtual event handlers, overide them in your derived class
		virtual void OnClose( wxCloseEvent& event ){ event.Skip(); }
		virtual void OnQuit( wxCommandEvent& event ){ event.Skip(); }
		virtual void OnAbout( wxCommandEvent& event ){ event.Skip(); }
		virtual void OnA1( wxGridEvent& event ){ event.Skip(); }
		virtual void saveClientName( wxFocusEvent& event ){ event.Skip(); }
		virtual void getClienteName( wxUpdateUIEvent& event ){ event.Skip(); }
		
	
	public:
		GUIFrame( wxWindow* parent, wxWindowID id = wxID_ANY, const wxString& title = wxT("YAE"), const wxPoint& pos = wxDefaultPosition, const wxSize& size = wxSize( 800,600 ), long style = wxDEFAULT_FRAME_STYLE|wxTAB_TRAVERSAL );
		~GUIFrame();
		void m_splitter4OnIdle( wxIdleEvent& )
		{
		m_splitter4->SetSashPosition( 120 );
		m_splitter4->Disconnect( wxEVT_IDLE, wxIdleEventHandler( GUIFrame::m_splitter4OnIdle ), NULL, this );
		}
		
	
};

#endif //__GUIFrame__
