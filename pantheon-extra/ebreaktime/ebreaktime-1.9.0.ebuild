# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Break time manager, designed for ElementaryOS."
HOMEPAGE="https://github.com/Dirli/ebreaktime"
SRC_URI="https://github.com/Dirli/ebreaktime/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="+indicator +libnotify nls"

DEPEND="
	$(vala_depend)
	nls? ( sys-devel/gettext )
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgee
	indicator? ( pantheon-base/wingpanel )
	sys-apps/dbus
	sys-auth/polkit[introspection]
	x11-libs/gtk+:3
	libnotify? ( x11-libs/libnotify )
	x11-libs/libXScrnSaver
"

src_prepare() {
	default
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dindicator=$(usex indicator true false)
		-Dnotify=$(usex libnotify true false)
	)
	meson_src_configure
}

pkg_preinst() {
	gnome2_schemas_savelist
}

pkg_postinst() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}

pkg_postrm() {
	xdg_icon_cache_update
	gnome2_schemas_update
	xdg_desktop_database_update
}
