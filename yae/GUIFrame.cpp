///////////////////////////////////////////////////////////////////////////
// C++ code generated with wxFormBuilder (version Dec 29 2008)
// http://www.wxformbuilder.org/
//
// PLEASE DO "NOT" EDIT THIS FILE!
///////////////////////////////////////////////////////////////////////////

#include "wx/wxprec.h"

#ifdef __BORLANDC__
#pragma hdrstop
#endif //__BORLANDC__

#ifndef WX_PRECOMP
#include <wx/wx.h>
#endif //WX_PRECOMP

#include "GUIFrame.h"

///////////////////////////////////////////////////////////////////////////

GUIFrame::GUIFrame( wxWindow* parent, wxWindowID id, const wxString& title, const wxPoint& pos, const wxSize& size, long style ) : wxFrame( parent, id, title, pos, size, style )
{
	this->SetSizeHints( wxDefaultSize, wxDefaultSize );
	
	mbar = new wxMenuBar( 0 );
	fileMenu = new wxMenu();
	wxMenuItem* menuFileQuit;
	menuFileQuit = new wxMenuItem( fileMenu, idMenuQuit, wxString( wxT("&Quit") ) + wxT('\t') + wxT("Alt+F4"), wxT("Quit the application"), wxITEM_NORMAL );
	fileMenu->Append( menuFileQuit );
	
	mbar->Append( fileMenu, wxT("&File") );
	
	helpMenu = new wxMenu();
	wxMenuItem* menuHelpAbout;
	menuHelpAbout = new wxMenuItem( helpMenu, idMenuAbout, wxString( wxT("&About") ) + wxT('\t') + wxT("F1"), wxT("Show info about this application"), wxITEM_NORMAL );
	helpMenu->Append( menuHelpAbout );
	
	mbar->Append( helpMenu, wxT("&Help") );
	
	this->SetMenuBar( mbar );
	
	statusBar = this->CreateStatusBar( 2, wxST_SIZEGRIP, wxID_ANY );
	wxBoxSizer* bSizer1;
	bSizer1 = new wxBoxSizer( wxVERTICAL );
	
	m_notebook1 = new wxNotebook( this, wxID_ANY, wxDefaultPosition, wxDefaultSize, 0 );
	m_panel3 = new wxPanel( m_notebook1, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL );
	wxBoxSizer* bSizer7;
	bSizer7 = new wxBoxSizer( wxVERTICAL );
	
	m_panel51 = new wxPanel( m_panel3, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL );
	wxBoxSizer* bSizer8;
	bSizer8 = new wxBoxSizer( wxHORIZONTAL );
	
	m_calendar1 = new wxCalendarCtrl( m_panel51, wxID_ANY, wxDefaultDateTime, wxDefaultPosition, wxDefaultSize, wxCAL_SHOW_HOLIDAYS );
	bSizer8->Add( m_calendar1, 0, wxALL, 5 );
	
	m_htmlWin1 = new wxHtmlWindow( m_panel51, wxID_ANY, wxDefaultPosition, wxSize( 500,168 ), wxHW_SCROLLBAR_AUTO );
	bSizer8->Add( m_htmlWin1, 0, wxALL, 5 );
	
	m_panel51->SetSizer( bSizer8 );
	m_panel51->Layout();
	bSizer8->Fit( m_panel51 );
	bSizer7->Add( m_panel51, 1, wxEXPAND | wxALL, 5 );
	
	m_htmlWin4 = new wxHtmlWindow( m_panel3, wxID_ANY, wxDefaultPosition, wxSize( 790,290 ), wxHW_SCROLLBAR_AUTO );
	bSizer7->Add( m_htmlWin4, 0, wxALL, 5 );
	
	m_panel3->SetSizer( bSizer7 );
	m_panel3->Layout();
	bSizer7->Fit( m_panel3 );
	m_notebook1->AddPage( m_panel3, wxT("Fornecedores"), true );
	m_panel1 = new wxPanel( m_notebook1, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL );
	wxBoxSizer* bSizer3;
	bSizer3 = new wxBoxSizer( wxVERTICAL );
	
	m_splitter4 = new wxSplitterWindow( m_panel1, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxSP_3D );
	m_splitter4->Connect( wxEVT_IDLE, wxIdleEventHandler( GUIFrame::m_splitter4OnIdle ), NULL, this );
	m_scrolledWindow1 = new wxScrolledWindow( m_splitter4, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxHSCROLL|wxVSCROLL );
	m_scrolledWindow1->SetScrollRate( 5, 5 );
	wxBoxSizer* bSizer4;
	bSizer4 = new wxBoxSizer( wxVERTICAL );
	
	m_treeCtrl2 = new wxTreeCtrl( m_scrolledWindow1, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTR_DEFAULT_STYLE );
	bSizer4->Add( m_treeCtrl2, 0, wxALL, 5 );
	
	m_scrolledWindow1->SetSizer( bSizer4 );
	m_scrolledWindow1->Layout();
	bSizer4->Fit( m_scrolledWindow1 );
	m_scrolledWindow2 = new wxScrolledWindow( m_splitter4, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxHSCROLL|wxVSCROLL );
	m_scrolledWindow2->SetScrollRate( 5, 5 );
	wxBoxSizer* bSizer5;
	bSizer5 = new wxBoxSizer( wxVERTICAL );
	
	m_grid1 = new wxGrid( m_scrolledWindow2, wxID_ANY, wxDefaultPosition, wxDefaultSize, 0 );
	
	// Grid
	m_grid1->CreateGrid( 12, 3 );
	m_grid1->EnableEditing( true );
	m_grid1->EnableGridLines( true );
	m_grid1->EnableDragGridSize( false );
	m_grid1->SetMargins( 0, 0 );
	
	// Columns
	m_grid1->EnableDragColMove( false );
	m_grid1->EnableDragColSize( true );
	m_grid1->SetColLabelSize( 30 );
	m_grid1->SetColLabelValue( 0, wxT("data") );
	m_grid1->SetColLabelValue( 1, wxT("desc") );
	m_grid1->SetColLabelValue( 2, wxT("valor") );
	m_grid1->SetColLabelAlignment( wxALIGN_CENTRE, wxALIGN_CENTRE );
	
	// Rows
	m_grid1->EnableDragRowSize( true );
	m_grid1->SetRowLabelSize( 50 );
	m_grid1->SetRowLabelAlignment( wxALIGN_CENTRE, wxALIGN_CENTRE );
	
	// Label Appearance
	m_grid1->SetLabelFont( wxFont( 9, 74, 90, 90, false, wxT("Sans") ) );
	
	// Cell Defaults
	m_grid1->SetDefaultCellFont( wxFont( 9, 74, 90, 90, false, wxT("Sans") ) );
	m_grid1->SetDefaultCellAlignment( wxALIGN_LEFT, wxALIGN_TOP );
	bSizer5->Add( m_grid1, 0, wxALL, 5 );
	
	m_scrolledWindow2->SetSizer( bSizer5 );
	m_scrolledWindow2->Layout();
	bSizer5->Fit( m_scrolledWindow2 );
	m_splitter4->SplitVertically( m_scrolledWindow1, m_scrolledWindow2, 120 );
	bSizer3->Add( m_splitter4, 1, wxEXPAND, 5 );
	
	m_panel1->SetSizer( bSizer3 );
	m_panel1->Layout();
	bSizer3->Fit( m_panel1 );
	m_notebook1->AddPage( m_panel1, wxT("Contabil"), false );
	m_panel2 = new wxPanel( m_notebook1, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL );
	wxBoxSizer* bSizer51;
	bSizer51 = new wxBoxSizer( wxVERTICAL );
	
	m_cliente_name = new wxTextCtrl( m_panel2, wxID_ANY, wxEmptyString, wxDefaultPosition, wxDefaultSize, 0 );
	bSizer51->Add( m_cliente_name, 0, wxALL, 5 );
	
	m_panel2->SetSizer( bSizer51 );
	m_panel2->Layout();
	bSizer51->Fit( m_panel2 );
	m_notebook1->AddPage( m_panel2, wxT("Clientes"), false );
	m_panel5 = new wxPanel( m_notebook1, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL );
	m_notebook1->AddPage( m_panel5, wxT("Produtos"), false );
	m_panel6 = new wxPanel( m_notebook1, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL );
	m_notebook1->AddPage( m_panel6, wxT("a page"), false );
	m_panel7 = new wxPanel( m_notebook1, wxID_ANY, wxDefaultPosition, wxDefaultSize, wxTAB_TRAVERSAL );
	m_notebook1->AddPage( m_panel7, wxT("a page"), false );
	
	bSizer1->Add( m_notebook1, 1, wxEXPAND | wxALL, 5 );
	
	this->SetSizer( bSizer1 );
	this->Layout();
	
	// Connect Events
	this->Connect( wxEVT_CLOSE_WINDOW, wxCloseEventHandler( GUIFrame::OnClose ) );
	this->Connect( menuFileQuit->GetId(), wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( GUIFrame::OnQuit ) );
	this->Connect( menuHelpAbout->GetId(), wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( GUIFrame::OnAbout ) );
	m_grid1->Connect( wxEVT_GRID_CELL_LEFT_CLICK, wxGridEventHandler( GUIFrame::OnA1 ), NULL, this );
	m_cliente_name->Connect( wxEVT_KILL_FOCUS, wxFocusEventHandler( GUIFrame::saveClientName ), NULL, this );
	m_cliente_name->Connect( wxEVT_UPDATE_UI, wxUpdateUIEventHandler( GUIFrame::getClienteName ), NULL, this );
}

GUIFrame::~GUIFrame()
{
	// Disconnect Events
	this->Disconnect( wxEVT_CLOSE_WINDOW, wxCloseEventHandler( GUIFrame::OnClose ) );
	this->Disconnect( wxID_ANY, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( GUIFrame::OnQuit ) );
	this->Disconnect( wxID_ANY, wxEVT_COMMAND_MENU_SELECTED, wxCommandEventHandler( GUIFrame::OnAbout ) );
	m_grid1->Disconnect( wxEVT_GRID_CELL_LEFT_CLICK, wxGridEventHandler( GUIFrame::OnA1 ), NULL, this );
	m_cliente_name->Disconnect( wxEVT_KILL_FOCUS, wxFocusEventHandler( GUIFrame::saveClientName ), NULL, this );
	m_cliente_name->Disconnect( wxEVT_UPDATE_UI, wxUpdateUIEventHandler( GUIFrame::getClienteName ), NULL, this );
}
