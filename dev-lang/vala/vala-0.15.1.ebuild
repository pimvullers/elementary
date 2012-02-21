# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/vala/vala-0.14.2-r1.ebuild,v 1.1 2012/02/04 22:38:36 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools alternatives eutils gnome2

DESCRIPTION="Vala - Compiler for the GObject type system"
HOMEPAGE="http://live.gnome.org/Vala"

LICENSE="LGPL-2.1"
SLOT="0.16"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~x86-fbsd ~x86-linux"
IUSE="test +vapigen"

RDEPEND=">=dev-libs/glib-2.16:2"
DEPEND="${RDEPEND}
	!${CATEGORY}/${PN}:0
	sys-devel/flex
	|| ( sys-devel/bison dev-util/byacc dev-util/yacc )
	dev-util/pkgconfig
	dev-libs/libxslt
	test? (
		dev-libs/dbus-glib
		>=dev-libs/glib-2.26:2 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-unversioned
		$(use_enable vapigen)"
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
}

src_install() {
	gnome2_src_install

	insinto /usr/share/aclocal
	newins vala.m4 vala-${SLOT/./-}.m4
}

pkg_postinst() {
	gnome2_pkg_postinst
	alternatives_auto_makesym /usr/share/aclocal/vala.m4 "vala-0-[0-9][0-9].m4"
}

pkg_postrm() {
	gnome2_pkg_postrm
	alternatives_auto_makesym /usr/share/aclocal/vala.m4 "vala-0-[0-9][0-9].m4"
}
