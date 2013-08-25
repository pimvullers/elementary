# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-lang/vala/vala-0.14.2-r2.ebuild,v 1.11 2013/03/26 14:01:12 jer Exp $

EAPI="4"
GCONF_DEBUG="no"
GNOME2_LA_PUNT="yes"

inherit autotools eutils gnome2

DESCRIPTION="Vala - Compiler for the GObject type system"
HOMEPAGE="http://live.gnome.org/Vala"

LICENSE="LGPL-2.1"
SLOT="0.14"
KEYWORDS="alpha amd64 arm hppa ia64 ~mips ppc ppc64 sh sparc x86 ~amd64-fbsd ~x86-fbsd ~amd64-linux ~x86-linux"
IUSE="test +vapigen"

RDEPEND=">=dev-libs/glib-2.16:2
	>=dev-libs/vala-common-${PV}"
DEPEND="${RDEPEND}
	!${CATEGORY}/${PN}:0
	dev-libs/libxslt
	sys-devel/flex
	virtual/pkgconfig
	virtual/yacc
	test? (
		dev-libs/dbus-glib
		>=dev-libs/glib-2.26:2 )"

pkg_setup() {
	G2CONF="${G2CONF}
		--disable-unversioned
		$(use_enable vapigen)"
	DOCS="AUTHORS ChangeLog MAINTAINERS NEWS README"
}

src_prepare() {
	epatch "${FILESDIR}/${P}-gobject-introspection-1.36.patch"

	# Patch from 0.15.x, needed for libchamplain:0.12, bug #402013,
	# https://bugzilla.gnome.org/show_bug.cgi?id=669379
	epatch "${FILESDIR}/${PN}-0.14.2-cogl-pango-1.0.patch"

	eautoreconf
	gnome2_src_prepare
}
