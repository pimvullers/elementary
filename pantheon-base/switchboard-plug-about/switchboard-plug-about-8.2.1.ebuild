# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=8

VALA_MIN_API_VERSION=0.22

inherit meson vala

DESCRIPTION="Switchboard plug to show system information"
HOMEPAGE="https://github.com/elementary/settings-system"
SRC_URI="https://github.com/elementary/settings-system/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="3"
KEYWORDS="amd64"
IUSE="systemd"

RDEPEND="
	dev-libs/glib:2
	sys-apps/fwupd[introspection]
	dev-libs/appstream[vala]
	pantheon-base/switchboard:3
	dev-libs/granite:7
	gui-libs/gtk:4
	gui-libs/libadwaita:1
	gnome-base/libgtop:2
	net-libs/libsoup:3.0
	dev-libs/libgudev
	sys-fs/udisks:2[introspection]
	sys-auth/polkit[introspection]
	systemd? ( sys-apps/systemd )
	!systemd? ( app-admin/openrc-settingsd )
"
DEPEND="${RDEPEND}
	$(vala_depend)
	virtual/pkgconfig
"

S="${WORKDIR}/settings-system-${PV}"

src_prepare() {
	eapply "${FILESDIR}/${PN}-8.2.0_drop_packagekit.patch"
	eapply_user
	vala_setup
}

pkg_postinst() {
	use systemd || einfo "Ensure openrc-settingsd is running when you want to use this plug."
}
