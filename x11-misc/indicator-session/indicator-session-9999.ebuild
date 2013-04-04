# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils autotools-utils bzr

DESCRIPTION="Session indicator"
HOMEPAGE="https://launchpad.net/indicator-session"
EBZR_REPO_URI="lp:indicator-session"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE="nls policykit static-libs"

RDEPEND="
	dev-libs/dbus-glib
	>=dev-libs/glib-2.35.4:2
	>=dev-libs/libdbusmenu-0.5.90:3[gtk]
	dev-libs/libindicator:3
	!pantheon-extra/indicator-pantheon-session
	policykit? ( sys-auth/polkit )
	virtual/udev[gudev]
	x11-libs/gtk+:3"
DEPEND="${RDEPEND}
	dev-util/intltool
	virtual/pkgconfig
	gnome-base/gnome-common
	nls? ( sys-devel/gettext )"

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh

	autotools-utils_src_prepare
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

