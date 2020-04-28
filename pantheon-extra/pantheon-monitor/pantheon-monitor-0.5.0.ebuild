# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils meson vala xdg-utils

DESCRIPTION="Manage processes and monitor system resources in ElementaryOS"
HOMEPAGE="https://github.com/Dirli/pantheon-monitor"
SRC_URI="https://github.com/Dirli/pantheon-monitor/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+indicator"

DEPEND="
	>=dev-lang/vala-0.40
	sys-devel/gettext
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-libs/glib:2
	dev-libs/granite
	dev-libs/libgee
	gnome-base/libgtop:2
	indicator? ( pantheon-base/wingpanel )
	sys-fs/udisks:2
	x11-libs/bamf
	x11-libs/cairo
	x11-libs/gtk+:3
	x11-libs/libwnck:3
"

src_prepare() {
	default
	vala_src_prepare
}

src_configure() {
	local emesonargs=(
		-Dindicator=$(usex indicator true false)
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
