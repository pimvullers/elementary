# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit meson

DESCRIPTION="Common components for building D-Bus system services"
HOMEPAGE="https://gitlab.gnome.org/pwithnall/libgsystemservice"
SRC_URI="https://gitlab.gnome.org/pwithnall/libgsystemservice/-/archive/${PV}/${P}.tar.bz2"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64"

RDEPEND="
	>=dev-libs/glib-2.71:2
	sys-apps/systemd
	sys-auth/polkit
"
DEPEND="${RDEPEND}"
BDEPEND="
	sys-devel/gettext
	virtual/pkgconfig
"

src_configure() {
	local emesonargs=(
		-Dgtk_doc=false
	)
	meson_src_configure
}
