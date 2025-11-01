# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.40

inherit gnome2 meson vala systemd

DESCRIPTION="A simple, powerful, sexy file manager for the Pantheon desktop"
HOMEPAGE="https://github.com/elementary/files"
SRC_URI="https://github.com/elementary/files/archive/${PV}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/files-${PV}"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64"
IUSE="systemd"

DEPEND="
	$(vala_depend)
	virtual/pkgconfig
"
RDEPEND="${DEPEND}
	dev-db/sqlite:3
	dev-libs/glib:2
	<dev-libs/granite-7:0
	dev-libs/libgee:0.8
	x11-libs/gtk+:3[X,wayland]
	gui-libs/libhandy:1
	dev-libs/libportal[gtk]
	x11-libs/pango
	media-libs/libcanberra
	net-libs/libcloudproviders[vala]
	dev-libs/libgit2-glib[vala]
	systemd? ( sys-apps/systemd )
"

src_prepare() {
	eapply_user
	sed -i 's/flatpak-builder/true/' filechooser-portal/meson.build
	vala_setup
}

src_configure() {
	local emesonargs=(
		-Dwith-zeitgeist=disabled
		-Dsystemduserunitdir=$(usex systemd $(systemd_get_userunitdir) no)
	)
	meson_src_configure
}
