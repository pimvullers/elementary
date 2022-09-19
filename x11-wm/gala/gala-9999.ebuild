# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit git-r3 gnome2 systemd meson vala

DESCRIPTION="Pantheon's Window Manager"
HOMEPAGE="https://github.com/elementary/gala"
SRC_URI="" # Ignore gnome.org default SRC_URI due to gnome2 inherit
EGIT_REPO_URI="https://github.com/elementary/gala.git"

LICENSE="GPL-3"
SLOT="0"
IUSE="systemd"

VALA_USE_DEPEND="vapigen"

RDEPEND="
	media-libs/libcanberra
	>=dev-libs/glib-2.44:2
	dev-libs/granite:0
	dev-libs/libgee:0.8
	gnome-base/gnome-desktop:3
	>=gnome-base/gnome-settings-daemon-3.15.2
	media-libs/gexiv2
	>=x11-libs/gtk+-3.10.0:3
	>=x11-misc/plank-0.11.0
	>=x11-wm/mutter-3.35.1:=
"

DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	vala_setup

	sed -i -e "s#'vapigen'#'${VAPIGEN}'#" meson.build
}

src_configure() {
	local emesonargs=(
		-Dsystemd=$(usex systemd true false)
		-Dsystemduserunitdir=$(usex systemd $(systemd_get_userunitdir) no)
	)
	meson_src_configure
}
