# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/gobject-introspection/gobject-introspection-1.38.0.ebuild,v 1.1 2013/12/23 22:54:05 eva Exp $

EAPI="5"
GCONF_DEBUG="no"
PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="xml"

inherit gnome2 python-single-r1 toolchain-funcs

DESCRIPTION="Introspection infrastructure for generating gobject library bindings for various languages"
HOMEPAGE="http://live.gnome.org/GObjectIntrospection/"

LICENSE="LGPL-2+ GPL-2+"
SLOT="0"
IUSE="cairo doctool test"
REQUIRED_USE="
	${PYTHON_REQUIRED_USE}
	test? ( cairo )
"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86 ~amd64-fbsd ~x86-fbsd ~x86-freebsd ~x86-interix ~amd64-linux ~arm-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~sparc-solaris ~sparc64-solaris ~x64-solaris ~x86-solaris"

RDEPEND="
	>=dev-libs/gobject-introspection-common-${PV}
	>=dev-libs/glib-2.36:2
	doctool? ( dev-python/mako )
	virtual/libffi:=
	!<dev-lang/vala-0.14.0
	${PYTHON_DEPS}
"
# Wants real bison, not virtual/yacc
DEPEND="${RDEPEND}
	>=dev-util/gtk-doc-am-1.15
	sys-devel/bison
	sys-devel/flex
	virtual/pkgconfig
"
# PDEPEND to avoid circular dependencies, bug #391213
PDEPEND="cairo? ( x11-libs/cairo[glib] )"

pkg_setup() {
	python-single-r1_pkg_setup
}

src_configure() {
	if ! has_version "x11-libs/cairo[glib]"; then
		# Bug #391213: enable cairo-gobject support even if it's not installed
		# We only PDEPEND on cairo to avoid circular dependencies
		export CAIRO_LIBS="-lcairo -lcairo-gobject"
		export CAIRO_CFLAGS="-I${EPREFIX}/usr/include/cairo"
	fi

	# To prevent crosscompiling problems, bug #414105
	gnome2_src_configure \
		--disable-static \
		CC=$(tc-getCC) \
		YACC=$(type -p yacc) \
		$(use_with cairo) \
		$(use_enable doctool)
}

src_install() {
	DOCS="AUTHORS CONTRIBUTORS ChangeLog NEWS README TODO"
	gnome2_src_install

	# Prevent collision with gobject-introspection-common
	rm -v "${ED}"usr/share/aclocal/introspection.m4 \
		"${ED}"usr/share/gobject-introspection-1.0/Makefile.introspection || die
	rmdir "${ED}"usr/share/aclocal || die
}
