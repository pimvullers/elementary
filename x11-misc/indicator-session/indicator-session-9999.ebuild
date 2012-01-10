# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit gnome2-utils autotools-utils bzr

DESCRIPTION="Session indicator"
HOMEPAGE="https://launchpad.net/indicator-session"
EBZR_REPO_URI="lp:indicator-session"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="static-libs"

RDEPEND="
	>=dev-libs/libindicator-0.3.19
	>=dev-libs/libdbusmenu-0.4.92
	>=x11-libs/gtk+-3.0:3"
DEPEND="${RDEPEND}
	dev-util/pkgconfig"

src_prepare() {
	NOCONFIGURE=1 ./autogen.sh
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
}

pkg_postrm() {
	gnome2_schemas_update --uninstall
}

