# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils bzr

DESCRIPTION="Pantheon fork of the session indicator"
HOMEPAGE="https://launchpad.net/indicator-pantheon-session"
EBZR_REPO_URI="lp:indicator-pantheon-session"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="nls policykit static-libs"

RDEPEND="
	dev-libs/dbus-glib
	dev-libs/glib:2
	>=dev-libs/libdbusmenu-0.5.90:3[gtk]
	dev-libs/libindicator:3
	policykit? ( sys-auth/polkit )
	virtual/udev[gudev]
	x11-libs/gtk+:3
	!x11-misc/indicator-session"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	gnome-base/gnome-common
	nls? ( sys-devel/gettext )"

AUTOTOOLS_AUTORECONF=yes

src_prepare() {
	sed -i 's/packagekit-glib2//' configure.ac

#	NOCONFIGURE=1 ./autogen.sh

	autotools-utils_src_prepare
}

src_configure() {
	local myeconfargs=(
		--disable-apt
	)

	autotools-utils_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update
}

