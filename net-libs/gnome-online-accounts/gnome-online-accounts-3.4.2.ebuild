# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-libs/gnome-online-accounts/Attic/gnome-online-accounts-3.4.2.ebuild,v 1.5 2013/03/29 23:31:06 eva dead $

EAPI=5

GNOME2_LA_PUNT="yes"

inherit gnome2

DESCRIPTION="GNOME framework for accessing online accounts"
HOMEPAGE="http://www.gnome.org/"

LICENSE="LGPL-2+"
SLOT="0"
IUSE="doc gnome +introspection"
KEYWORDS="~amd64 ~ppc ~ppc64 ~x86"

# pango used in goaeditablelabel
# libsoup used in goaoauthprovider
# Require {glib,gdbus-codegen}-2.30.0 due to GDBus API changes between 2.29.92
# and 2.30.0
RDEPEND="
	>=dev-libs/glib-2.30.0:2
	dev-libs/json-glib
	gnome-base/libgnome-keyring
	net-libs/libsoup:2.4
	|| ( >=net-libs/libsoup-2.42 >=net-libs/libsoup-gnome-2.26:2.4 )
	net-libs/rest:0.7
	net-libs/webkit-gtk:3
	>=x11-libs/gtk+-3.0.0:3
	>=x11-libs/libnotify-0.7
	x11-libs/pango

	introspection? ( >=dev-libs/gobject-introspection-0.6.2 )"
# goa-daemon can launch gnome-control-center
PDEPEND="gnome? ( >=gnome-base/gnome-control-center-3.2[gnome-online-accounts(+)] )"
DEPEND="${RDEPEND}
	dev-libs/libxslt
	>=dev-util/gdbus-codegen-2.30.0
	dev-util/intltool
	sys-devel/gettext
	virtual/pkgconfig

	doc? ( >=dev-util/gtk-doc-1.3 )"

pkg_setup() {
	# TODO: Give users a way to set the G/Y!/FB/Twitter/Windows Live secrets
	G2CONF="${G2CONF}
		--disable-static
		--enable-documentation
		--enable-facebook
		--enable-windows-live"
	DOCS="NEWS" # README is empty
}
