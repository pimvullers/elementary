# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

VALA_MIN_API_VERSION=0.40

inherit meson vala xdg-utils

DESCRIPTION="Parental controls support library"
HOMEPAGE="https://gitlab.freedesktop.org/pwithnall/malcontent"
SRC_URI="https://gitlab.freedesktop.org/pwithnall/malcontent/-/archive/${PV}/${P}.tar.bz2"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="doc"

RDEPEND="
	dev-libs/appstream
	>=dev-libs/glib-2.50:2
	dev-libs/gobject-introspection
	sys-apps/flatpak
	sys-apps/accountsservice
	sys-auth/polkit
	sys-libs/pam
	x11-libs/gtk+:3
"

DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	sed -i "s/subdir('tests')//" libmalcontent/meson.build
	vala_src_prepare
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
