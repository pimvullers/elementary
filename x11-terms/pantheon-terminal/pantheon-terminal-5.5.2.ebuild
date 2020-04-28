# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="The terminal of the 21st century"
HOMEPAGE="https://github.com/elementary/terminal"
SRC_URI="https://github.com/elementary/terminal/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="nls patched"

RDEPEND="
	dev-libs/appstream
	dev-libs/glib:2
	>=dev-libs/granite-5.3.0
	x11-libs/libnotify
	x11-libs/gtk+:3
	x11-libs/libnotify
	x11-libs/vte:2.91[vala]
"
DEPEND="${RDEPEND}
	>=dev-lang/vala-0.40
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"

S="${WORKDIR}/terminal-${PV}"

src_prepare() {
	eapply_user
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dubuntu-bionic-patched-vte=$(usex patched true false)
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

pkg_postrm() {
	gnome2_schemas_update
	xdg_icon_cache_update
	xdg_desktop_database_update
}

