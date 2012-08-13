# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/vala/vala-0.16.1-r1.ebuild,v 1.1 2012/06/25 07:41:17 tetromino Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit alternatives gnome2

DESCRIPTION="Vala - Compiler for the GObject type system"
HOMEPAGE="http://live.gnome.org/Vala"

LICENSE="LGPL-2.1"
SLOT="0.18"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-linux"
IUSE="test +vapigen"

RDEPEND=">=dev-libs/glib-2.16:2"
DEPEND="${RDEPEND}
	!${CATEGORY}/${PN}:0
	sys-devel/flex
	|| ( sys-devel/bison dev-util/byacc dev-util/yacc )
	virtual/pkgconfig
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
	if use vapigen; then
		insinto /usr/share/vala-${SLOT}
		doins vapigen/Makefile.vapigen
	fi
}

pkg_postinst() {
	gnome2_pkg_postinst
	alternatives_auto_makesym /usr/share/aclocal/vala.m4 "vala-0-[0-9][0-9].m4"
	use vapigen &&
		alternatives_auto_makesym /usr/share/vala/Makefile.vapigen \
			"/usr/share/vala-0.[0-9][0-9]/Makefile.vapigen"
}

pkg_postrm() {
	gnome2_pkg_postrm
	alternatives_auto_makesym /usr/share/aclocal/vala.m4 "vala-0-[0-9][0-9].m4"
	use vapigen &&
		alternatives_auto_makesym /usr/share/vala/Makefile.vapigen \
			"/usr/share/vala-0.[0-9][0-9]/Makefile.vapigen"
}
