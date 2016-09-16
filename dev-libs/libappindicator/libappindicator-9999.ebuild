# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libappindicator/libappindicator-12.10.0.ebuild,v 1.3 2013/05/12 14:40:30 pacho Exp $

EAPI=4
VALA_MIN_API_VERSION=0.20
VALA_USE_DEPEND="vapigen"

inherit autotools-utils vala bzr

DESCRIPTION="A library to allow applications to export a menu into the Unity Menu bar"
HOMEPAGE="http://launchpad.net/libappindicator"
EBZR_REPO_URI="lp:libappindicator"

LICENSE="LGPL-2.1 LGPL-3"
SLOT="3"
KEYWORDS=""
IUSE="+introspection static-libs"

RDEPEND=">=dev-libs/dbus-glib-0.98
	>=dev-libs/glib-2.26
	>=dev-libs/libdbusmenu-0.6.2[gtk3]
	>=dev-libs/libindicator-12.10.0:3
	>=x11-libs/gtk+-3.2:3
	introspection? ( >=dev-libs/gobject-introspection-1 )"
DEPEND="${RDEPEND}
	virtual/pkgconfig
	introspection? ( $(vala_depend) )"

pkg_setup() {
	AUTOTOOLS_AUTORECONF=1
	DOCS=( AUTHORS ChangeLog )
}

src_prepare() {
	use introspection && vala_src_prepare
	autotools-utils_src_prepare

	# Disable MONO for now because of http://bugs.gentoo.org/382491
	sed -i -e '/^MONO_REQUIRED_VERSION/s:=.*:=9999:' configure || die
}

src_configure() {
	# http://bugs.gentoo.org/409133
	export APPINDICATOR_PYTHON_CFLAGS=' '
	export APPINDICATOR_PYTHON_LIBS=' '

	local myeconfargs=(
		--disable-silent-rules
		--with-html-dir=/usr/share/doc/${PF}/html
		--with-gtk=3
		VALA_API_GEN="${VAPIGEN}"
	)

	autotools-utils_src_configure
}
