# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit gnome2 meson vala

DESCRIPTION="An easy parental controls plug for Switchboard"
HOMEPAGE="https://github.com/elementary/switchboard-plug-parental-controls"
SRC_URI="https://github.com/elementary/switchboard-plug-parental-controls/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"
IUSE="systemd"

RDEPEND="
	!pantheon-base/switchboard-plug-parental-controls:0
	pantheon-base/switchboard-plug-parental-controls-helper[systemd?]
	dev-libs/glib:2
	dev-libs/granite:7
	dev-libs/libgee:0.8
	dev-libs/malcontent
	pantheon-base/switchboard:3
	sys-auth/polkit
	systemd? ( sys-apps/systemd )
	sys-apps/accountsservice
	sys-apps/flatpak
	gui-libs/gtk:4
	gui-libs/libadwaita:1
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

src_prepare() {
	eapply_user
	#use systemd || sed -i -e '/systemd_dep/d' meson.build data/meson.build
	sed -i -e '/systemd_dep/d' meson.build data/meson.build
	vala_setup
}

src_install() {
	meson_src_install
	rm -r "${ED}/usr/bin"
	rm -r "${ED}/usr/libexec"
	rm -r "${ED}/usr/share/{applications,dbus-1}"
}
