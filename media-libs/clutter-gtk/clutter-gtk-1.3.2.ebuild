# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-libs/clutter-gtk/clutter-gtk-1.2.0.ebuild,v 1.4 2012/07/14 13:21:33 blueness Exp $

EAPI="4"
GCONF_DEBUG="yes"
CLUTTER_LA_PUNT="yes"

# inherit clutter after gnome2 so that defaults aren't overriden
inherit gnome2 clutter gnome.org

DESCRIPTION="Clutter-GTK - GTK+3 Integration library for Clutter"

SLOT="1.0"
KEYWORDS="~alpha ~amd64 ~mips ~ppc ~ppc64 ~x86"
IUSE="doc examples +introspection"

# XXX: Needs gtk with X support (!directfb)
RDEPEND="
	>=x11-libs/gtk+-3.2.0:3[introspection?]
	>=media-libs/clutter-1.9.16:1.0[introspection?]
	introspection? ( >=dev-libs/gobject-introspection-0.9.12 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	>=sys-devel/gettext-0.18
	doc? ( >=dev-util/gtk-doc-1.14 )"

pkg_setup() {
	DOCS="NEWS README"
	EXAMPLES="examples/{*.c,redhand.png}"
	G2CONF="${G2CONF}
		--disable-maintainer-flags
		--enable-deprecated
		$(use_enable introspection)"
}
